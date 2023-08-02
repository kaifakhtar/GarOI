import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

import '../../../models/note_modal.dart';
import 'note_service.dart';

class NotePdfService {
  final BuildContext context;

  NotePdfService(this.context);

  // Future<void> generatePDF(String vidId) async {
  //   PermissionStatus storageStatus = await Permission.storage.request();
  //   // Check if storage permission is granted
  //   //final PermissionStatus status = await Permission.storage.status;
  //   if (storageStatus.isGranted) {
  //     // Permission is already granted
  //     await createPDFAndOpen(vidId);
  //   } else if (storageStatus.isDenied) {
  //     // Permission has been denied once
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text("We need this permission to export your notes.")));
  //    // final bool? isOpenSettings = await showOpenSettingsDialog();
  //   } 
  //     if (storageStatus.isPermanentlyDenied) {
  //       // User has chosen to open app settings
  //       await openAppSettings();
  //     } 
  // }

  Future<void> createPDFAndOpen(String vidId) async {
    // Create a new PDF document
    final pdf = pw.Document();
    // Get the notes from the database
    final notes = await getNotesFromDatabase(vidId);

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          final noteWidgets = notes.map((note) {
            return pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Text(note.title,
                    style: pw.TextStyle(
                        fontSize: 16.sp, fontBold: pw.Font.courier())),
                pw.SizedBox(height: 8),
                pw.Text(note.description, style: const pw.TextStyle(fontSize: 12)),
                pw.SizedBox(height: 36)
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
    Directory generalDownloadDir = Directory('/storage/emulated/0/Download');
    final path = '${generalDownloadDir.path}/notes$vidId.pdf';

    // Save the PDF document to a file
    final file = await File(path).writeAsBytes(await pdf.save());

    if(kDebugMode) print('PDF saved to: $path');
    OpenFile.open(path);
  }

  Future<List<Note>> getNotesFromDatabase(String videoId) async {
    final database = NoteDataBaseService();
    return database.getNotesForVideo(videoId);
  }

  Future<bool?> showOpenSettingsDialog() {
    // Show a dialog to ask the user if they want to open app settings
    return showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permission Required'),
          content: const Text(
              'Please grant storage permission to generate the PDF.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context, false),
            ),
            TextButton(
              child: const Text('Open Settings'),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        );
      },
    );
  }
}
