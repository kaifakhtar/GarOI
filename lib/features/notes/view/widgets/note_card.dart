import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ytyt/features/notes/bloc/note_bloc.dart';
import 'package:ytyt/features/notes/view/screens/note_screen.dart';

import '../../../../models/note_modal.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final String vidId;
  const NoteCard({
    Key? key,
    required this.note,
    required this.vidId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 328.w,
          height: 296.h,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF7D4),
            boxShadow: [
              BoxShadow(
                blurRadius: 4.r,
                color: const Color(0x33000000),
                offset: const Offset(0, 2),
              )
            ],
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.h, 16.h, 0, 16.h),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    note.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.outfit(
                        fontSize: 16.sp, color: Colors.black87),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(note.description,
                          maxLines: 9,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.outfit(
                              fontSize: 14.sp, color: Colors.black54)),
                      Text(timeago.format(note.timestamp),
                          style: GoogleFonts.outfit(
                              fontSize: 12.sp, color: Colors.black38)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
            bottom: 28.h,
            right: 16.w,
            child: GestureDetector(
              onTap: () {
                final notebloc = BlocProvider.of<NoteBloc>(context);
                notebloc.add(DeleteNote(noteId: note.id!));
                notebloc.add(LoadNotes(videoId: vidId));
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
            )),
        Positioned(
            bottom: 28.h,
            right: 56.w,
            child: GestureDetector(
              onTap: () {
              // //  final notebloc = BlocProvider.of<NoteBloc>(context);
              //     Navigator.push(
              //                             context,
              //                             MaterialPageRoute(
              //                                 builder: (context) => NoteScreen(
              //                                       videoId:vidId ,
              //                                     )));
              },
              child: CircleAvatar(
                radius: 16.r,
                backgroundColor: Colors.blue[900],
                child: Icon(
                  Iconsax.note_remove,
                  color: Colors.white,
                  size: 20.h,
                ),
              ),
            ))
      ],
    ); // Generated code for this Container Widget...
  }
}
