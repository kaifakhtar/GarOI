import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ytyt/colors/app_colors.dart';
import 'package:ytyt/features/notes/view/screens/note_view_screen.dart';
import 'package:ytyt/routes/routes_imports.dart';

import '../../../../models/note_modal.dart';

class SmallNoteCard extends StatelessWidget {
  const SmallNoteCard({super.key, required this.note});
  final Note note;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => NoteViewScreen(note: note)));
      },
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xFFFFF7D4),
            borderRadius: BorderRadius.all(Radius.circular(16.r))),
        height: 200.h,
        width: 200.w,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.readexPro(fontSize: 16.sp),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    note.description,
                  style: GoogleFonts.lato(fontSize: 12.sp),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
