// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:ytyt/colors/app_colors.dart';
import 'package:ytyt/features/notes/bloc/note_bloc.dart';
import 'package:ytyt/features/notes/view/screens/note_screen.dart';
import 'package:ytyt/features/notes/view/widgets/note_card.dart';
import 'package:ytyt/models/video_model.dart';

import '../features/video_player/view/widgets/video_page_view.dart';

class VideoScreen extends StatefulWidget {
  final Video currentVideo;

  VideoScreen({required this.currentVideo});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen>
    with SingleTickerProviderStateMixin {
  late YoutubePlayerController _controller;
  late final NoteBloc noteBloc;
  late TabController _tabController;
  final noteCardListScrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> requestStoragePermission() async {
    final permission = Permission.storage.request();
    if (await permission.isGranted) {
      // Permission is granted, you can proceed with your app logic here
      if (kDebugMode) print("permission granted");
    } else {
      // If permissions are denied, you can show a dialog or request again
      if (await permission.isPermanentlyDenied) {
        if (kDebugMode) print("permission permanently denied");
        // The user has permanently denied storage permission, you can open settings to prompt them manually
        openAppSettings();
      } else {
        if (kDebugMode) print("again requesting permission ");
        // The user denied storage permission, you can request again
        requestStoragePermission();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    // tabs(),
                    Expanded(
                        child: VideoPageView(
                      currentVideo: widget.currentVideo,
                      tabController: _tabController,
                    ))
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
              if (kDebugMode) print('Player is ready.');
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
                        videoTitle: widget.currentVideo.title,
                        videoId: widget.currentVideo.id,
                      )));
        },
        label: Text(
          "Add note",
          style: GoogleFonts.readexPro(color: AppColors.gold),
        ),
        icon: const Icon(
          Iconsax.note_1,
          color: AppColors.gold,
        ),
      ),
    );
  }

  void openModalBottomSheet(
      BuildContext context, String title, String description) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.readexPro(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Divider(
                thickness: 1.h,
              ),
              SizedBox(height: 8.h),
              SingleChildScrollView(
                child: Text(
                  description,
                  style: GoogleFonts.outfit(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget videoPlayerCard(Widget player) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 400.h,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          player,
          SizedBox(
            height: 8.h,
          ),
          tabs(),

          // InkWell(
          //   onTap: () => openModalBottomSheet(
          //       context, 'Desription', widget.currentVideo.description),
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         CircleAvatar(
          //           radius: 20.r,
          //           foregroundImage:
          //               NetworkImage(widget.currentVideo.thumbnailUrl),
          //         ),
          //         SizedBox(
          //           width: 8.w,
          //         ),
          //         Flexible(
          //           child: Text(
          //             maxLines: 2,
          //             overflow: TextOverflow.ellipsis,
          //             widget.currentVideo.title,
          //             style: GoogleFonts.readexPro(
          //                 fontSize: 14.sp, fontWeight: FontWeight.normal),
          //           ),
          //         ),
          //         Text(
          //           "...more",
          //           style: GoogleFonts.readexPro(
          //               color: Colors.black54, fontSize: 10.sp),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          const Divider()
        ],
      ),
    );
  }

  Widget tabs() {
    return Container(
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: Colors.black.withOpacity(
      //         .1), // You can choose any color you want for the border
      //     width: 2.0,
      //     // Adjust the width of the border as needed
      //   ),
      //   borderRadius: BorderRadius.circular(12.r),
      // ),
      padding: EdgeInsets.all(12.h),
      width: 200.w,
      height: 60.h,
      child: TabBar(
        unselectedLabelColor: Colors.grey,
        labelColor: Colors.black,
        indicatorColor: Colors.amber,
        indicatorWeight: 2,
        indicator: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8.0,
              spreadRadius: 4.0,
            ),
          ],
          color: Colors.amber,
          borderRadius: BorderRadius.circular(12.r),
        ),
        controller: _tabController,
        tabs: const [
          Tab(
            text: 'Notes',
          ),
          Tab(
            text: 'Read',
          ),
        ],
      ),
    );
  }

  // Widget noNotesWidget() {
  //   return // Generated code for this Column Widget...
  //       Column(
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       Image.asset(
  //         'assets/images/book_goi.png',
  //         height: 200.h,
  //         width: 200.h,
  //       ),
  //       Padding(
  //         padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12.h),
  //         child: Text(
  //           'Make notes!',
  //           style: GoogleFonts.readexPro(
  //               fontSize: 20.sp,
  //               fontWeight: FontWeight.w600,
  //               color: Colors.black87),
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8.h),
  //         child: Text(
  //           'Improved retention and understanding.',
  //           style:
  //               GoogleFonts.readexPro(fontSize: 14.sp, color: Colors.black54),
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8.h),
  //         child: Text(
  //           'Enhanced organization and structure.',
  //           style:
  //               GoogleFonts.readexPro(fontSize: 14.sp, color: Colors.black54),
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8.h),
  //         child: Text(
  //           'Promotes active learning.',
  //           style:
  //               GoogleFonts.readexPro(fontSize: 14.sp, color: Colors.black54),
  //         ),
  //       ),
  //       Padding(
  //         padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
  //         child: Text(
  //           'Increases focus and attention.',
  //           style:
  //               GoogleFonts.readexPro(fontSize: 14.sp, color: Colors.black54),
  //         ),
  //       ),
  //       Text(
  //         'Effective study aid.',
  //         style: GoogleFonts.readexPro(fontSize: 14.sp, color: Colors.black54),
  //       ),
  //     ],
  //   );
  // }
}
