import 'dart:io';
import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

import '../../../models/note_modal.dart';
import 'note_service.dart';

class NotePdfService {
  Future<void> generatePDF(String vidId) async {
    // Check if storage permission is granted
    if (await Permission.storage.request().isGranted) {
      // Create a new PDF document
      final pdf = pw.Document();
      // Get the notes from the database
      final notes = await getNotesFromDatabase(vidId);
      // final combinedNoteDescription =
      //     notes.join('\n\n'); // Concatenate notes with line breaks
      // Add "Hello, World!" to the PDF
 pdf.addPage(
  pw.Page(
    build: (pw.Context context) {
      final noteWidgets = notes.map((note) {
        return pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.start,
          children: [
            pw.Text(note.title,style: pw.TextStyle(fontSize: 20.sp,fontBold: pw.Font.courier())),
            pw.SizedBox(height: 8.h),
            pw.Text(note.description,style: pw.TextStyle(fontSize: 14.sp)),
            pw.SizedBox(height: 36.h)
          ],
        );
      }).toList();

      return pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        children: noteWidgets,
      );
    },
  ),
);

      // Get the document directory path
      // final directory = await getTemporaryDirectory();
      Directory generalDownloadDir = Directory('/storage/emulated/0/Download');
      final path = '${generalDownloadDir.path}/notes$vidId.pdf';

      // Save the PDF document to a file
      final file = await File(path).writeAsBytes(await pdf.save());

      print('PDF saved to: $path');
      OpenFile.open(path);
    } else {
      // Permission denied
      print('Storage permission denied.');
    }
  }

  Future<List<Note>> getNotesFromDatabase(String videoId) async {
    // Open the database
    // final databasePath = await getDatabasesPath();
    // final database = await openDatabase('$databasePath/notes.db');

    // // Fetch notes from the database for the given videoId
    // final notes = await database.query(
    //   'notes',
    //   where: 'video_id = ?',
    //   whereArgs: [videoId],
    // );
    final database = NoteDataBaseService();
    return database.getNotesForVideo(videoId);

    // // Close the database
    // await database.close();

    // // Convert database rows to Note objects
    // return notes.map((noteMap) => Note.fromMap(noteMap)).toList();
  }
}
