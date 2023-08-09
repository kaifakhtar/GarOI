import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:ytyt/colors/app_colors.dart';

import '../../../../models/video_model.dart';
import '../../../../screens/video_screen.dart';
import 'circular_perc_indicator.dart';

class VideoListTile extends StatefulWidget {
  final Video video;

  const VideoListTile({Key? key, required this.video}) : super(key: key);

  @override
  State<VideoListTile> createState() => _VideoListTileState();
}

class _VideoListTileState extends State<VideoListTile> {
  bool isTapped = false;
  Color getPercentageColor(double percentage) {
    if (percentage < 20) {
      return Colors.red;
    } else if (percentage >= 20 && percentage <= 80) {
      return const Color.fromARGB(255, 255, 185, 81);
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Ink(
          color: isTapped ? Colors.amber[100] : Colors.white,
          child: InkWell(
            splashColor: AppColors.gold.withOpacity(0.2),
            onTap: () {
              setState(() {
                isTapped = true;
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoScreen(
                    currentVideo: widget.video,
                  ),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
              child: Stack(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: Container(
                          width: 150.w,
                          height: 90.h,
                          decoration: BoxDecoration(
                            color: isTapped ? Colors.amber[100] : Colors.white,
                            image: DecorationImage(
                              image: NetworkImage(widget.video.thumbnailUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      SizedBox(
                        width: 160.w,
                        height: 80.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.video.title,
                              style: GoogleFonts.readexPro(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            if (widget.video.dateTime != null)
                              Text(
                                timeago.format(widget.video.dateTime!),
                                style: GoogleFonts.readexPro(
                                  fontSize: 10.sp,
                                  color: Colors.black45,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircularPercentageIndicator(
                      percentage: 100,
                      radius: 12.r,
                      progressColor: getPercentageColor(100),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
