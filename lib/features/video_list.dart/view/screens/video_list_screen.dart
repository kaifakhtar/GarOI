import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ytyt/features/video_list.dart/bloc/video_list_bloc.dart';

import '../../../../models/playlistmodal.dart';

class VideoListScreen extends StatefulWidget {
  final Playlist selectedPlaylist;

  const VideoListScreen({super.key, required this.selectedPlaylist});

  @override
  State<VideoListScreen> createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  late final VideoListBloc videoListBloc;
  @override
  void initState() {
    super.initState();

    videoListBloc = BlocProvider.of<VideoListBloc>(context);
    videoListBloc.add(VideoListReset());
    videoListBloc
        .add(VideoListFetch(selectedPlaylist: widget.selectedPlaylist));

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   // Reset the bloc and trigger the fetch event after the first frame
    //   videoListBloc.add(VideoListReset());
    //   videoListBloc.add(VideoListFetch(selectedPlaylist: widget.selectedPlaylist));
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(
              height: 24.h,
            ),
            ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image.network(
                  widget.selectedPlaylist.thumbnailUrl,
                  height: 184.h,
                  width: 328,
                  fit: BoxFit.cover,
                )),
            SizedBox(
              height: 24.h,
            ),
            Text(
              widget.selectedPlaylist.title,
              style: GoogleFonts.lato(fontSize: 14.sp),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              widget.selectedPlaylist.description.isNotEmpty
                  ? widget.selectedPlaylist.description
                  : "No description",
              style: GoogleFonts.lato(fontSize: 12.sp),
            ),
            const Divider(),
            SizedBox(
              height: 24.h,
            ),
            Text(
              "Videos",
              style: GoogleFonts.lato(fontSize: 14.sp),
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
                        itemCount: state.videoList.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (state.videoList[index].title != 'Deleted video') {
                            return ListTile(
                              title: Text(state.videoList[index].title),
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
