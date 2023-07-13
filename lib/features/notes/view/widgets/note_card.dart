import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ytyt/features/notes/bloc/note_bloc.dart';
import 'package:ytyt/features/notes/view/screens/note_view_screen.dart';

import 'package:ytyt/features/notes/view/screens/update_note_screen.dart';

import '../../../../models/note_modal.dart';
import 'delete_confirmation_dialog.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final String vidId;
  const NoteCard({
    Key? key,
    required this.note,
    required this.vidId,
  }) : super(key: key);
  void showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteConfirmationDialog(
          onDelete: () {
            final noteBloc = BlocProvider.of<NoteBloc>(context);
            noteBloc.add(DeleteNote(noteId: note.id!));
            noteBloc.add(LoadNotes(videoId: vidId));
            Navigator.pop(context); // Close the dialog after delete
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => NoteViewScreen(
              note: note,
            ),
          ),
        );
      },
      child: Container(
        width: 328.w,
        height: 296.h,
        decoration: BoxDecoration(
          color: const Color(0xFFFFF7D4),
          boxShadow: [
            BoxShadow(
              blurRadius: 4.r,
              color: const Color.fromARGB(51, 131, 131, 131),
              offset: const Offset(0, 0),
            )
          ],
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.h, 16.h, 16.h, 16.h),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      note.title.isNotEmpty ? note.title : "Untitled",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.readexPro(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  SizedBox(
                    height: 200.h,
                    child: Text(
                      note.description,
                      maxLines: 11,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                        fontSize: 14.sp,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 16.h,
              right: 16.w,
              child: GestureDetector(
                onTap: () {
                  // final noteBloc = BlocProvider.of<NoteBloc>(context);
                  // noteBloc.add(DeleteNote(noteId: note.id!));
                  // noteBloc.add(LoadNotes(videoId: vidId));
                  showDeleteConfirmation(context);
                },
                child: CircleAvatar(
                  radius: 16.r,
                  backgroundColor: Colors.red,
                  child: Icon(
                    Iconsax.note_remove,
                    color: Colors.white,
                    size: 20.h,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 16.h,
              right: 56.w,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateNoteScreen(
                        videoId: vidId,
                        oldNote: note,
                      ),
                    ),
                  );
                },
                child: CircleAvatar(
                  radius: 16.r,
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Iconsax.magicpen5,
                    color: Colors.white,
                    size: 20.h,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 16.h,
              left: 16.w,
              child: Text(
                timeago.format(note.timestamp),
                style: GoogleFonts.readexPro(
                  fontSize: 12.sp,
                  color: Colors.black38,
                ),
              ),
            ),
            Positioned(
              bottom: 16.h,
              left: 108.w,
              child: Text(
                note.words > 1
                    ? "${note.words.toString()} words"
                    : "${note.words.toString()} word",
                style: GoogleFonts.readexPro(
                  fontSize: 12.sp,
                  color: Colors.black38,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
