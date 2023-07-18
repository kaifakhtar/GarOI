import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:ytyt/colors/app_colors.dart';

import '../../../../models/video_model.dart';
import '../../../../screens/video_screen.dart';

class VideoListTile extends StatelessWidget {
  // final String imageUrl;
  // final String title;
  final Video video;
  const VideoListTile({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Ink(
          color: Colors.white,
          child: InkWell(
            splashColor: AppColors.gold.withOpacity(0.2),
            onTap: () {
              // final videolistbloc = BlocProvider.of<VideoListBloc>(context);
              // videolistbloc.add(VideoListFetch(selectedPlaylist: playlist));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VideoScreen(
                            currentVideo: video,
                          )));
            },
            child: Container(
              // color: Colors.white,
              //height: 130.h,
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Container(
                        width: 150.w,
                        height: 090.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(video.thumbnailUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    // Positioned(
                    //   bottom: 0,
                    //   left: 0,
                    //   right: 0,
                    //   child: Container(
                    //     alignment: Alignment.center,
                    //     decoration: BoxDecoration(
                    //       color: Colors.black.withOpacity(0.70),
                    //       borderRadius: BorderRadius.only(
                    //         bottomLeft: Radius.circular(16.r),
                    //         bottomRight: Radius.circular(16.r),
                    //       ),
                    //     ),
                    //     padding: EdgeInsets.symmetric(
                    //         horizontal: 8.w, vertical: 4.h),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Icon(
                    //           Iconsax.video_square,
                    //           size: 16.h,
                    //           color: Colors.white,
                    //         ),
                    //         SizedBox(
                    //           width: 4.w,
                    //         ),
                    //         Text(
                    //           'Playlist',
                    //           style: GoogleFonts.lato(
                    //             fontSize: 12.sp,
                    //             color: Colors.white,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ]),
                  SizedBox(width: 16.w),
                  SizedBox(
                    width: 160.w,
                    height: 80.h,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          video.title,
                          style: GoogleFonts.readexPro(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal,
                          ),
                          maxLines: 3, // Limit the text to 2 lines
                          overflow: TextOverflow
                              .ellipsis, // Apply ellipsis for overflow
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        if (video.dateTime != null)
                          Text(
                            timeago.format(video.dateTime!),
                            style: GoogleFonts.readexPro(
                                fontSize: 10.sp, color: Colors.black45),
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        //const Divider()
      ],
    );
  }
}
