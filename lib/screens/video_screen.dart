import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:ytyt/models/video_model.dart';

class VideoScreen extends StatefulWidget {
  final Video currentVideo;

  VideoScreen({required this.currentVideo});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.currentVideo.id,
      flags: const YoutubePlayerFlags(
        mute: false,
        useHybridComposition: false,
        autoPlay: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: YoutubePlayerBuilder(
          onEnterFullScreen: () {
            _controller.pause();
          },
          builder: (context, player) {
            return Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 400.h,
                    ),
                    const Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: TextField(
                          // controller: _notesController,
                          maxLines:
                              10, // Allow the text field to grow dynamically
                          decoration: InputDecoration(
                            hintText: 'Pause and write your notes here...',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                    top: 0,
                    left: 0,
                    //width: MediaQuery.of(context).size.width,
                    child: videoPlayerCard(player)),
                Positioned(
                    bottom: 24.h,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: SizedBox(
                          width: ScreenUtil.defaultSize.width,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Pause and take notes ...",
                                  style: GoogleFonts.outfit(fontSize: 16.sp),
                                ),
                                Icon(
                                  Iconsax.pen_add,
                                  size: 24,
                                  color: Colors.black,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                          .animate()
                          .fadeIn()
              
                          .shake(duration: 2000.ms, curve: Curves.easeIn,hz: 8.h),
                    ))
              ],
            );
          },
          player: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            onReady: () {
              //_controller.addListener(listener);
              print('Player is ready.');
            },
          ),
        ),
      ),
    );
  }

  Widget videoPlayerCard(Widget player) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 400.h,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          player,
          SizedBox(
            height: 4.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24.r,
                  foregroundImage:
                      NetworkImage(widget.currentVideo.thumbnailUrl),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Flexible(
                  child: Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    widget.currentVideo.title,
                    style: GoogleFonts.outfit(
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider()
        ],
      ),
    );
  }
}
