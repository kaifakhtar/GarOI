import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import 'package:ytyt/features/video_list.dart/bloc/video_list_bloc.dart';

import '../../../../models/playlistmodal.dart';
import '../../../video_list.dart/view/screens/video_list_screen.dart';

class PlaylistTile extends StatelessWidget {
  // final String imageUrl;
  // final String title;
  final Playlist playlist;
  const PlaylistTile({required this.playlist});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            final videolistbloc = BlocProvider.of<VideoListBloc>(context);
            videolistbloc.add(VideoListFetch(selectedPlaylist: playlist));
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => VideoListScreen(selectedPlaylist: playlist,)));
          },
          child: Container(
            // height: 130.h,
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            child: Row(
              children: [
                Stack(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Container(
                      width: 150.w,
                      height: 90.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(playlist.thumbnailUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.70),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16.r),
                          bottomRight: Radius.circular(16.r),
                        ),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Iconsax.video_square,
                            size: 16.h,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(
                            'Playlist',
                            style: GoogleFonts.lato(
                              fontSize: 12.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
                SizedBox(width: 16.w),
                SizedBox(
                  width: 160.w,
                  height: 80.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        playlist.title,
                        style: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2, // Limit the text to 2 lines
                        overflow: TextOverflow
                            .ellipsis, // Apply ellipsis for overflow
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Videos : ${playlist.videoCount.toString()}",
                        style: GoogleFonts.lato(
                          fontSize: 12.sp,
                          color: Colors.black54,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        //const Divider()
      ],
    );
  }
}
