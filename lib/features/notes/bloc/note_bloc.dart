import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:faker/faker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../../../models/note_modal.dart';
import '../note_service/note_service.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteDataBaseService noteDataBaseService;

  NoteBloc({required this.noteDataBaseService}) : super(NoteInitial()) {
    on<LoadNotes>(_loadNotes);
    on<AddNote>(_addNote);
    on<DeleteNote>(_deleteNote);
    on<UpdateNote>(_updateNote);
    on<ExportNotesToPdf>(_exportNotesToPdf);
  }

  FutureOr<void> _loadNotes(LoadNotes event, Emitter<NoteState> emit) async {
    emit(NoteLoading());
    try {
      List<Note> fetchedNotes =
          await noteDataBaseService.getNotesForVideo(event.videoId);
      print(fetchedNotes.length);
      if (fetchedNotes.isNotEmpty) {
        print(fetchedNotes.length);
        emit(NoteLoaded(notes: fetchedNotes));
      } else {
        emit(NoNotes());
      }
    } catch (e) {
      print("Error:${e.toString}");
    }
  }

  FutureOr<void> _addNote(AddNote event, Emitter<NoteState> emit) async {
    emit(NoteLoading());
    try {
      await noteDataBaseService.insertNoteForVideo(event.note);
      print("after add note");
      emit(NoteAdded());
    } catch (e) {
      print("Error:${e.toString}");
    }
  }

  FutureOr<void> _deleteNote(DeleteNote event, Emitter<NoteState> emit) {
    emit(NoteLoading());
    try {
      noteDataBaseService.deleteNote(event.noteId);
      emit(NoteSuccess(message: "Successfully deleted"));
    } catch (e) {
      emit(NoteError(message: "Some error happened while deleting"));
    }
  }

  FutureOr<void> _updateNote(UpdateNote event, Emitter<NoteState> emit) {
    emit(NoteLoading());
    try {
      noteDataBaseService.updateNote(event.updatedNote);
      //  emit(NoteSuccess(message: "Done updating"));
      emit(NoteAdded());
    } catch (e) {
      emit(NoteError(message: "Something error happened while updating"));
    }
  }

  FutureOr<void> _exportNotesToPdf(
      ExportNotesToPdf event, Emitter<NoteState> emit) async {
    //final DatabaseHelper dbHelper = DatabaseHelper();
    final List<Note> notes =
        await noteDataBaseService.getNotesForVideo(event.videoID);

    final pdf = await generatePDF(notes);
    final Directory dir = Directory('/storage/emulated/0/Download');
    //final String dir = (await getExternalStorageDirectory())!.path;
    //  final String dir = (await getApplicationDocumentsDirectory()).path;
    //String _localPath = (await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS))!;
    final String path = '${dir.path}/notes_${event.videoID}.pdf';
    if (kDebugMode) print("path is$path");
    final file = File(path);
    await file.writeAsBytes(await pdf.save());
    // Printing.layoutPdf(
    //         onLayout: (PdfPageFormat format) async => pdf.save(),
    //       );
    await OpenFile.open(path);
  }

  Future<pw.Document> generatePDF(List<Note> notes) async {
    final titleFont = await PdfGoogleFonts.notoNaskhArabicSemiBold();
    final descFont = await PdfGoogleFonts.notoNaskhArabicRegular();
    var data =
        await rootBundle.load('assets/fonts/droid_arabic naskh_regular.ttf');
    var arabicfont = Font.ttf(data);

    final pdf = pw.Document();
    List<pw.Widget> widgets = [];
    final goilogo = await buildCustomHeader(notes[0], titleFont);
    widgets.add(goilogo);
    //widgets.add();
    for (int i = 0; i < notes.length; i++) {
      widgets.add(pw.Text("${i + 1}) ${notes[i].title}",
          style: pw.TextStyle(font: titleFont, fontSize: 20),
          textDirection: TextDirection.rtl));
      widgets.add(pw.SizedBox(height: 5));
      widgets.add(pw.Paragraph(
          text: notes[i].description,
          style: pw.TextStyle(
            font: descFont,
            fontSize: 14,
          )));
      widgets.add(pw.SizedBox(height: 14));
    }
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => <pw.Widget>[...widgets],
      ),
    );
    // Printing.layoutPdf(
    //       onLayout: (PdfPageFormat format) async => pdf.save(),
    //     );

    return pdf;
  }

  Future<pw.Widget> buildCustomHeader(Note note, Font headerfont) async {
    final goiLogo = pw.MemoryImage(
      (await rootBundle.load(
        'assets/images/goi.jpg',
      ))
          .buffer
          .asUint8List(),
    );
    return pw.Container(
        child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: <pw.Widget>[
          pw.Image(goiLogo, height: 100.h, width: 100.h),
          pw.Header(
              child: pw.Text(note.videoTitle,
                  style: pw.TextStyle(
                      font: headerfont, fontSize: 12, color: PdfColors.grey),
                  textDirection: TextDirection.ltr)),
          pw.SizedBox(height: 12)
        ]));
  }
}
