import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ytyt/colors/app_colors.dart';
import 'package:ytyt/features/notes/view/screens/note_view_screen.dart';


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
          //  color: const Color(0xFFFFF7D4),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              AppColors.gold, // Start color
              Color(0xffFFF8CF), // End color
            ],
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 4.r,
              color: const Color.fromARGB(51, 131, 131, 131),
              offset: const Offset(0, 0),
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(16.r)),
          // border: Border.all(
          //   color: AppColors.gold, // Set the border color here
          //   width: 1.0, // Set the border width if needed
          // ),
        ),
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
