import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ytyt/features/all_notes/view/widgets/small_note_card.dart';

import '../../../../models/vid_id_and_list_of_notes_of_that.dart';
import '../../../notes/view/widgets/note_card.dart';

class AllVideoNotesWidget extends StatelessWidget {
  final VidIdAndListOfNotesModal vidIdAndListOfNotesModal;

  const AllVideoNotesWidget({Key? key, required this.vidIdAndListOfNotesModal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        vidIdAndListOfNotesModal.notesOfThisVideoId[0].videoTitle,
        style: GoogleFonts.readexPro(
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
        ),
      ),
      children: [
        SizedBox(
          height: 200.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: vidIdAndListOfNotesModal.notesOfThisVideoId.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
                  child: SmallNoteCard(
                    note: vidIdAndListOfNotesModal.notesOfThisVideoId[index],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
