// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ytyt/features/notes/bloc/note_bloc.dart';
import 'package:ytyt/features/notes/view/widgets/note_card.dart';

import 'package:ytyt/models/video_model.dart';

import '../../../pdf/view/widgets/select_pdf_view_widg.dart';
import 'need_permission.dart';

class VideoPageView extends StatefulWidget {
  final Video currentVideo;
  final TabController tabController;
  VideoPageView({
    Key? key,
    required this.currentVideo,
    required this.tabController,
  }) : super(key: key);

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

  Future<void> requestStoragePermission(BuildContext context) async {
    final permission = Permission.storage.request();
    if (await permission.isGranted) {
      // Permission is granted, you can proceed with your app logic here
      if (kDebugMode) print("permission granted");
    } else {
      // If permissions are denied, you can show a dialog or request again
      if (await permission.isPermanentlyDenied) {
        if (kDebugMode) print("permission permanently denied");

        if (mounted) {
          showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return NeedPermissionBottomSheet(
                  message: "We need permission to export your notes.",
                  buttonText: "Open Settings",
                  onButtonPressed: () {
                    Navigator.pop(context); // Close the bottom sheet
                    openAppSettings(); // Open the app settings
                  },
                );
              });
        } // The user has permanently denied storage permission, you can open settings to prompt them manually

        // openAppSettings();
      } else {
        if (kDebugMode) print("again requesting permission ");
        // The user denied storage permission, you can request again
        if (mounted) requestStoragePermission(context);
      }
    }
  }
Future<String?> _handleRenameNoteExport(BuildContext context) async {
  String? fileName;
  bool saveClicked = false; // Track if "Save" button was clicked

  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Enter a name'),
      content: TextField(
        onChanged: (value) {
          fileName = value;
        },
        decoration: const InputDecoration(hintText: 'File Name'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog without saving
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            saveClicked = true; // Mark "Save" button was clicked
            Navigator.of(context).pop(); // Close the dialog after saving
          },
          child: const Text('Save'),
        ),
      ],
    ),
  );

  if (saveClicked) {
    return fileName; // Return the filename if "Save" button was clicked
  } else {
    return null; // Return null if the dialog was dismissed or "Cancel" was clicked
  }
}


  @override
  Widget build(BuildContext context) {
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      controller: widget.tabController,
      children: [
        // Page 1: The page with the BlocBuilder
        BlocBuilder<NoteBloc, NoteState>(
          builder: (context, state) {
            if (state is NoteExportRename) {
//  _handleRenameNoteExport(context);
            }

            if (state is NoNotes) {
              return noNotesWidget();
            }
            if (state is NoteLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is NoteLoaded) {
              return Column(
                children: [
                  SizedBox(height: 0.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              String? filename;
                              // await requestStoragePermission(context)
                              //     .then((value) async {

                              // });
                              filename = await _handleRenameNoteExport(context);
                              if (filename != null) {
                                noteBloc.add(
                                  ExportNotesToPdf(
                                      videoID: widget.currentVideo.id,
                                      filename: filename),
                                );
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10000),
                              ),
                            ),
                            child: Text(
                              "Export notes",
                              style: GoogleFonts.readexPro(
                                  color: Colors.amber[700]),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
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
