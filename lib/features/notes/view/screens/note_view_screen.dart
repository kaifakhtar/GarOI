import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:ytyt/colors/app_colors.dart';
import '../../../../models/note_modal.dart';

class NoteViewScreen extends StatelessWidget {
  final Note note;
  const NoteViewScreen({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          "View note",
          style: GoogleFonts.readexPro(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: AppColors.gold,
      ),
      backgroundColor: const Color(0xFFFFF7D4),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 12.h, left: 16.h, right: 16.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title,
                  style: GoogleFonts.outfit(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  children: [
                    Text(
                      timeago.format(note.timestamp),
                      style: GoogleFonts.outfit(
                          fontSize: 12.sp, color: Colors.black38),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    // VerticalDivider(
                    //   thickness: 2,
                    //   width: 8,
                    //   color: Colors.black,
                    // ),
                    Text(
                      note.words > 1
                          ? "${note.words.toString()} words"
                          : "${note.words.toString()} word",
                      style: GoogleFonts.outfit(
                          fontSize: 12.sp, color: Colors.black38),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  note.description,
                  style: GoogleFonts.outfit(
                      fontSize: 16.sp, color: Colors.black87),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
