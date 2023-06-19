import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../models/note_modal.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  const NoteCard({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return // Generated code for this Container Widget...
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
                style: GoogleFonts.outfit(fontSize: 18.sp,),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:  EdgeInsetsDirectional.fromSTEB(0, 16.h, 0, 0),
                    child: Text(note.description,
                    maxLines: 9,
                    overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.outfit(
                            fontSize: 16.sp, color: Colors.black54)),
                  ),
                  Text(timeago.format(note.timestamp),
                      style: GoogleFonts.outfit(
                          fontSize: 12.sp, color: Colors.black38)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
