import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';

class NotePdfService {

    Future<void> generatePDF() async {
  // Create a new PDF document
  final pdf = pw.Document();

  // Add "Hello, World!" to the PDF
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Text('Hello, World!', style: pw.TextStyle(fontSize: 40)),
        );
      },
    ),
  );

  // Get the document directory path
  final directory = await getApplicationDocumentsDirectory();
  final path = '${directory.path}/hello_world.pdf';

  // Save the PDF document to a file
  final file = await File(path).writeAsBytes(await pdf.save());

  print('PDF saved to: $path');
   OpenFile.open(path);
}

}