import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../cubit/pdf_cubit.dart';

class SelectPdfAndView extends StatefulWidget {
  const SelectPdfAndView({super.key});

  @override
  State<SelectPdfAndView> createState() => _SelectPdfAndViewState();
}

class _SelectPdfAndViewState extends State<SelectPdfAndView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
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
              return Container(
                //// width:
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: SfPdfViewer.memory(state.pdfBytes),
                    ),
                    Positioned(
                      top: 0.0,
                      left: 0.0,
                      child: IconButton(
                          onPressed: () {
                            // Add button functionality here
                            BlocProvider.of<PdfCubit>(context).reset();
                          },
                          icon: Icon(Icons.arrow_back_ios_sharp)),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
