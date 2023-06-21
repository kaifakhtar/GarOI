import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ytyt/features/video_list.dart/bloc/video_list_bloc.dart';
import 'package:ytyt/features/video_list.dart/view/widgets/video_tile.dart';
import 'package:ytyt/screens/video_screen.dart';

import '../../../../models/playlistmodal.dart';

class VideoListScreen extends StatefulWidget {
  final Playlist selectedPlaylist;

  const VideoListScreen({super.key, required this.selectedPlaylist});

  @override
  State<VideoListScreen> createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  late final VideoListBloc videoListBloc;
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    videoListBloc = BlocProvider.of<VideoListBloc>(context);
    videoListBloc.add(VideoListReset());
    videoListBloc
        .add(VideoListFetch(selectedPlaylist: widget.selectedPlaylist));
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Reach the end of the list
      // Emit an event to fetch more videos
      print("In the _scrool");
      videoListBloc
          .add(VideoListFetch(selectedPlaylist: widget.selectedPlaylist));

      // Update the state in the BLoC
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Video",
          style: GoogleFonts.readexPro(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 4.h,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Shadow color
                    spreadRadius: 2.r, // Spread radius
                    blurRadius: 5.r, // Blur radius
                    offset: Offset(0, 2.h), // Offset in the x and y directions
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image.network(
                  widget.selectedPlaylist.thumbnailUrl,
                  height: 184.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Text(
              widget.selectedPlaylist.title,
              style: GoogleFonts.readexPro(
                  fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 12.h,
            ),
            Text(
              widget.selectedPlaylist.description.isNotEmpty
                  ? widget.selectedPlaylist.description
                  : "No description",
              maxLines: 3,
              overflow: TextOverflow.fade,
              style: GoogleFonts.outfit(fontSize: 14.sp, color: Colors.black45),
            ),
            const Divider(),
            SizedBox(
              height: 16.h,
            ),
            Text(
              'Videos',
              style: GoogleFonts.readexPro(
                fontSize: 18.sp,
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Expanded(
              child: SizedBox(
                child: BlocConsumer<VideoListBloc, VideoListState>(
                  listener: (context, state) {
                    if (state is VideoListError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Error occurred: ${state.errorMessage}'),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is VideoListData) {
                      return ListView.builder(
                        // controller: _scrollController,
                        itemCount: state.videoList.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (state.videoList[index].title != 'Deleted video' &&
                              state.videoList[index].title != 'Private video') {
                            return VideoListTile(
                                      video: state.videoList[index]);
                          }
                          return const SizedBox(
                            height: 0,
                          );
                        },
                      );
                    } else if (state is VideoListLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
