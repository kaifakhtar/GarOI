import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:ytyt/features/notes/bloc/note_bloc.dart';
import 'package:ytyt/features/notes/view/widgets/note_card.dart';
import 'package:ytyt/features/pdf/cubit/pdf_cubit.dart';
import 'package:ytyt/models/video_model.dart';

import '../../../pdf/view/widgets/select_pdf_view_widg.dart';

class VideoPageView extends StatefulWidget {
  final Video currentVideo;

  VideoPageView({required this.currentVideo});

  @override
  _VideoPageViewState createState() => _VideoPageViewState();
}

class _VideoPageViewState extends State<VideoPageView> {
  late final NoteBloc noteBloc;
  final noteCardListScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    noteBloc = BlocProvider.of<NoteBloc>(context);
    noteBloc.add(LoadNotes(videoId: widget.currentVideo.id));
  }

  Future<void> requestStoragePermission() async {
    // ... Your implementation of requestStoragePermission ...
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        // Page 1: The page with the BlocBuilder
        BlocBuilder<NoteBloc, NoteState>(
          builder: (context, state) {
            if (state is NoNotes) {
              return Center(
                child: noNotesWidget(),
              );
            }
            if (state is NoteLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is NoteLoaded) {
              return Column(
                children: [
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(
                        state.notes.length > 1
                            ? "${state.notes.length} cards"
                            : "${state.notes.length} card",
                        style: GoogleFonts.readexPro(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black38),
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          await requestStoragePermission();
                          noteBloc.add(
                            ExportNotesToPdf(videoID: widget.currentVideo.id),
                          );
                        },
                        child: const Text("Export notes"),
                      )
                    ],
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    height: 330.h,
                    child: Scrollbar(
                      controller: noteCardListScrollController,
                      scrollbarOrientation: ScrollbarOrientation.bottom,
                      child: ListView.builder(
                        controller: noteCardListScrollController,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: state.notes.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.h, horizontal: 16.w),
                            child: NoteCard(
                              note: state.notes[index],
                              vidId: widget.currentVideo.id,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }
            return const Text("Useless builder");
          },
        ),
        const SelectPdfAndView()
      ],
    );
  }

  Widget noNotesWidget() {
    return // Generated code for this Column Widget...
        Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/book_goi.png',
          height: 200.h,
          width: 200.h,
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12.h),
          child: Text(
            'Make notes!',
            style: GoogleFonts.readexPro(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8.h),
          child: Text(
            'Improved retention and understanding.',
            style:
                GoogleFonts.readexPro(fontSize: 14.sp, color: Colors.black54),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8.h),
          child: Text(
            'Enhanced organization and structure.',
            style:
                GoogleFonts.readexPro(fontSize: 14.sp, color: Colors.black54),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8.h),
          child: Text(
            'Promotes active learning.',
            style:
                GoogleFonts.readexPro(fontSize: 14.sp, color: Colors.black54),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
          child: Text(
            'Increases focus and attention.',
            style:
                GoogleFonts.readexPro(fontSize: 14.sp, color: Colors.black54),
          ),
        ),
        Text(
          'Effective study aid.',
          style: GoogleFonts.readexPro(fontSize: 14.sp, color: Colors.black54),
        ),
      ],
    );
  }
}
