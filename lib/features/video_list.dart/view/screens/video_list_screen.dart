import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ytyt/features/video_list.dart/bloc/video_list_bloc.dart';
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
        elevation: 0,
        title: Text("Video"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 4.h,
            ),
            ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image.network(
                  widget.selectedPlaylist.thumbnailUrl,
                  height: 184.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )),
            SizedBox(
              height: 12.h,
            ),
            Text(
              widget.selectedPlaylist.title,
              style: GoogleFonts.outfit(
                  fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              widget.selectedPlaylist.description.isNotEmpty
                  ? widget.selectedPlaylist.description
                  : "No description",
              style: GoogleFonts.outfit(fontSize: 14.sp, color: Colors.black45),
            ),
            const Divider(),
            SizedBox(
              height: 24.h,
            ),
            Text(
              "Videos",
              style: GoogleFonts.outfit(fontSize: 16.sp),
            ),
            SizedBox(
              height: 8.h,
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
                            return Card(
                              child: OpenContainer(
                                transitionType:
                                    ContainerTransitionType.fadeThrough,
                                closedBuilder: (context, action) {
                                  return ListTile(
                                    // onTap: () {
                                    //   Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //           builder: (context) => VideoScreen(
                                    //                 currentVideo:
                                    //                     state.videoList[index],
                                    //               )));
                                    // },
                                    leading: CircleAvatar(
                                      foregroundImage: NetworkImage(
                                          state.videoList[index].thumbnailUrl),
                                    ),
                                    title: Text(
                                      state.videoList[index].title,
                                      style:
                                          GoogleFonts.outfit(fontSize: 14.sp),
                                    ),
                                  );
                                },
                                openBuilder: (context, action) {
                                  return VideoScreen(
                                      currentVideo: state.videoList[index]);
                                },
                              ),
                            );
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
