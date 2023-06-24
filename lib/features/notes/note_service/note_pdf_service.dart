import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
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
  final BuildContext context;

  NotePdfService(this.context);

  Future<void> generatePDF(String vidId) async {
    PermissionStatus storageStatus = await Permission.storage.request();
    // Check if storage permission is granted
    //final PermissionStatus status = await Permission.storage.status;
    if (storageStatus.isGranted) {
      // Permission is already granted
      await createPDFAndOpen(vidId);
    } else if (storageStatus.isDenied) {
      // Permission has been denied once
      final bool? isOpenSettings = await showOpenSettingsDialog();
      if (isOpenSettings != null && isOpenSettings) {
        // User has chosen to open app settings
        await openAppSettings();
      } else {
        // User has chosen not to open app settings or dismissed the dialog
        print('Storage permission denied.');
      }
    } else {
      // Permission has not been requested yet
      final PermissionStatus requestedStatus =
          await Permission.storage.request();
      if (requestedStatus.isGranted) {
        // Permission has been granted
        await createPDFAndOpen(vidId);
      } else {
        // Permission has been denied or permanently denied
        print('Storage permission denied.');
      }
    }
  }

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
                        fontSize: 20.sp, fontBold: pw.Font.courier())),
                pw.SizedBox(height: 8.h),
                pw.Text(note.description, style: pw.TextStyle(fontSize: 14.sp)),
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
    Directory generalDownloadDir = Directory('/storage/emulated/0/Download');
    final path = '${generalDownloadDir.path}/notes$vidId.pdf';

    // Save the PDF document to a file
    final file = await File(path).writeAsBytes(await pdf.save());

    print('PDF saved to: $path');
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
