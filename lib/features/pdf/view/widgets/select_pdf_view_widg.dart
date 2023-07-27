import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../cubit/pdf_cubit.dart';

class SelectPdfAndView extends StatefulWidget {
  const SelectPdfAndView({super.key});

  @override
  State<SelectPdfAndView> createState() => _SelectPdfAndViewState();
}

class _SelectPdfAndViewState extends State<SelectPdfAndView> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Container(
            alignment: Alignment.center,
            child: BlocBuilder<PdfCubit, PdfState>(
              builder: (context, state) {
                if (state is PdfStateInitial) {
                  return ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<PdfCubit>(context).selectPdf();
                    },
                    child: Text(
                      "Select a book",
                      style: GoogleFonts.readexPro(color: Colors.black),
                    ),
                  );
                }
                if (state is PdfStateLoaded) {
               //   File pdfFile = File(state.path[0]);
                  return SfPdfViewer.memory(state.pdfBytes);
                }
                return const SizedBox.shrink();
              },
            ));
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}