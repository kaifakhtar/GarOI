// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:ytyt/colors/app_colors.dart';
import 'package:ytyt/features/notes/bloc/note_bloc.dart';

import 'package:ytyt/features/notes/view/screens/note_screen.dart';
import 'package:ytyt/features/notes/view/widgets/note_card.dart';
import 'package:ytyt/models/video_model.dart';

import '../features/notes/note_service/note_pdf_service.dart';

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
                      height: 300.h,
                    ),
                    BlocBuilder<NoteBloc, NoteState>(
                      builder: (context, state) {
                        if (state is NoNotes) {
                          print("No state ran");
                          return Center(
                            child: noNotesWidget(),
                          );
                        }

                        if (state is NoteLoading) {
                          print("Loading state ran");
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is NoteLoaded) {
                          return Column(
                            //   crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 20.h,
                              ),
                              // OutlinedButton.icon(
                              //     onPressed: () {
                              //       final notePdfService =
                              //           NotePdfService(context);
                              //       notePdfService
                              //           .generatePDF(widget.currentVideo.id);
                              //     },
                              //     icon: const Icon(Iconsax.export),
                              //     label: const Text("Export these notes")),
                              Text(
                                "${state.notes.length} cards",
                                style: GoogleFonts.outfit(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black38),
                              ),
                             const SizedBox(
                                height: 24,
                              ),
                              SizedBox(
                                height: 330.h,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: state.notes.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8.h, horizontal: 16.w),
                                      child: NoteCard(
                                          note: state.notes[index],
                                          vidId: widget.currentVideo.id),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        }
                        return const Text("Useless builer");
                      },
                    ),
                  ],
                ),
                Positioned(
                    top: 0,
                    left: 0,
                    //width: MediaQuery.of(context).size.width,
                    child: videoPlayerCard(player)),
                // Positioned(
                //     bottom: 24.h,
                //     child: Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: TakeNotesFloatingButton(
                //         videoId: widget.currentVideo.id,
                //       ),
                //     ))
              ],
            );
          },
          player: YoutubePlayer(
            controller: _controller,
            progressColors: const ProgressBarColors(
                handleColor: AppColors.gold, playedColor: AppColors.gold),
            showVideoProgressIndicator: true,
            onReady: () {
              //_controller.addListener(listener);
              print('Player is ready.');
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        heroTag: 'addnote',
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NoteScreen(
                        videoId: widget.currentVideo.id,
                      )));
        },
        label: Text(
          "Pause and add note",
          style: GoogleFonts.readexPro(color: AppColors.gold),
        ),
        icon: const Icon(
          Iconsax.note_1,
          color: AppColors.gold,
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
                    style: GoogleFonts.readexPro(
                        fontSize: 16.sp, fontWeight: FontWeight.w500),
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

  Widget noNotesWidget() {
    return // Generated code for this Column Widget...
        Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 56.h,
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
          child: Text(
            'Make notes!',
            style: GoogleFonts.readexPro(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
          child: Text(
            'Improved retention and understanding.',
            style:
                GoogleFonts.readexPro(fontSize: 14.sp, color: Colors.black54),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
          child: Text(
            'Enhanced organization and structure.',
            style:
                GoogleFonts.readexPro(fontSize: 14.sp, color: Colors.black54),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
          child: Text(
            'Promotes active learning.',
            style:
                GoogleFonts.readexPro(fontSize: 14.sp, color: Colors.black54),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
          child: Text(
            'Increases focus and attention.',
            style:
                GoogleFonts.readexPro(fontSize: 14.sp, color: Colors.black54),
          ),
        ),
        Text(
          'Effective study aid.',
          style: GoogleFonts.readexPro(fontSize: 14.sp, color: Colors.black54),
        ),
      ],
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
    return Align(
      alignment: Alignment.center,
      child: OpenContainer(
        closedBuilder: (context, action) {
          return SizedBox(
            width: ScreenUtil.defaultSize.width,
            child: Card(
              elevation: 4.h,
              color: const Color.fromARGB(255, 255, 241, 200),
              child: Padding(
                padding: EdgeInsets.all(16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pause and take notes ...",
                      style: GoogleFonts.outfit(
                          fontSize: 16.sp, color: Colors.black87),
                    ),
                    const Icon(
                      Iconsax.pen_add,
                      size: 24,
                      color: Colors.black,
                    )
                  ],
                ),
              ).animate().fadeIn(),
            ),
          );
        },
        openBuilder: (context, action) {
          return NoteScreen(
            videoId: videoId,
          );
        },
      ),
    );
  }
}
