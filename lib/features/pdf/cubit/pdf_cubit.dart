import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pdf_state.dart';

class PdfCubit extends Cubit<PdfState> {
  Uint8List? _pdfBytes;
  PdfCubit() : super(PdfStateInitial());

  void reset() {
    emit(PdfStateInitial());
  }

  void selectPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      _pdfBytes = await file.readAsBytes();
      // List<String> pdfPaths = result.files.map((file) => file.path!).toList();
      emit(PdfStateLoaded(_pdfBytes!)); //! hardcoded null check again
    }
  }

  ///Get the PDF document as bytes
// void getPdfBytes() async {
// final  _documentBytes = await http.readBytes(Uri.parse(
//       'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf'));
//   setState(() {});
// }
}
