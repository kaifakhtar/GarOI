import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ytyt/features/all_notes/view/widgets/small_note_card.dart';

import '../../../../models/vid_id_and_list_of_notes_of_that.dart';


class AllVideoNotesWidget extends StatefulWidget {
  final VidIdAndListOfNotesModal vidIdAndListOfNotesModal;

  const AllVideoNotesWidget({Key? key, required this.vidIdAndListOfNotesModal})
      : super(key: key);

  @override
  _AllVideoNotesWidgetState createState() => _AllVideoNotesWidgetState();
}

class _AllVideoNotesWidgetState extends State<AllVideoNotesWidget>
    with TickerProviderStateMixin {
  bool isExpanded = false;
  late AnimationController _animationController;
  bool isPlaying = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
  }

  void _handleOnPressed() {
    setState(() {
      isPlaying = !isPlaying;
      isPlaying
          ? _animationController.forward()
          : _animationController.reverse();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.h,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: InkWell(
        onTap: () {
          _handleOnPressed();
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        child: Container(
          padding: EdgeInsets.all(12.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2.r,
                blurRadius: 4.r,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      widget.vidIdAndListOfNotesModal.notesOfThisVideoId[0]
                          .videoTitle,
                      style: GoogleFonts.readexPro(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  AnimatedIcon(
                    icon: AnimatedIcons.view_list,
                    progress: _animationController,
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: isExpanded ? 200.h : 0,
                child: isExpanded
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.vidIdAndListOfNotesModal.notesOfThisVideoId
                                        .length >
                                    1
                                ? "${widget.vidIdAndListOfNotesModal.notesOfThisVideoId.length} cards"
                                : "${widget.vidIdAndListOfNotesModal.notesOfThisVideoId.length} card",
                            style: GoogleFonts.readexPro(color: Colors.black38),
                          ),
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.vidIdAndListOfNotesModal
                                  .notesOfThisVideoId.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 8.w),
                                  child: SmallNoteCard(
                                    note: widget.vidIdAndListOfNotesModal
                                        .notesOfThisVideoId[index],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
