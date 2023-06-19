// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:ytyt/features/notes/bloc/note_bloc.dart';

import 'package:ytyt/features/notes/view/screens/note_screen.dart';
import 'package:ytyt/features/notes/view/widgets/note_card.dart';
import 'package:ytyt/models/video_model.dart';

class VideoScreen extends StatefulWidget {
  final Video currentVideo;

  VideoScreen({required this.currentVideo});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late YoutubePlayerController _controller;
  late final NoteBloc noteBloc;
  @override
  void initState() {
    super.initState();

    noteBloc = BlocProvider.of<NoteBloc>(context);
    noteBloc.add(LoadNotes(videoId: widget.currentVideo.id));
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
                      height: 325.h,
                    ),
                    BlocBuilder<NoteBloc, NoteState>(
                      builder: (context, state) {
                        if (state is NoNotes) {
                          print("No state ran");
                          return const Center(
                            child: Text("No Notes"),
                          );
                        }

                        if (state is NoteLoading) {
                          print("Loading state ran");
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is NoteLoaded) {
                          return SizedBox(
                            height: 330.h,
                            child: Padding(
                              padding:  EdgeInsets.symmetric(vertical: 8.h),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: state.notes.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    child: NoteCard(note: state.notes[index],vidId:widget.currentVideo.id),
                                  );
                                },
                              ),
                            ),
                          );
                        }
                        return Text("Useless builer");
                      },
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
                      child: TakeNotesFloatingButton(
                        videoId: widget.currentVideo.id,
                      ),
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

class TakeNotesFloatingButton extends StatelessWidget {
  final String videoId;
  const TakeNotesFloatingButton({
    Key? key,
    required this.videoId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedBuilder: (context, action) {
        return Card(
          child: SizedBox(
            width: ScreenUtil.defaultSize.width,
            child: Padding(
              padding: EdgeInsets.all(16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Pause and take notes ...",
                    style: GoogleFonts.outfit(fontSize: 16.sp),
                  ),
                  const Icon(
                    Iconsax.pen_add,
                    size: 24,
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ),
        ).animate().fadeIn();
      },
      openBuilder: (context, action) {
        return NoteScreen(
          videoId: videoId,
        );
      },
    );
  }
}
