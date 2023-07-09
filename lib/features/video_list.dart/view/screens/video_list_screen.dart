import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ytyt/features/video_list.dart/bloc/video_list_bloc.dart';
import 'package:ytyt/features/video_list.dart/view/widgets/video_tile.dart';

import '../../../../models/playlistmodal.dart';
import '../widgets/image_video_title_desc_shimmer.dart';
import '../widgets/shimmer_video_tile.dart';

class VideoListScreen extends StatefulWidget {
  final Playlist selectedPlaylist;

  const VideoListScreen({required this.selectedPlaylist});

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
    // videoListBloc.add(VideoListReset());
    videoListBloc
        .add(VideoListFetch(selectedPlaylist: widget.selectedPlaylist));
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // videoListBloc
      //     .add(VideoListFetch(selectedPlaylist: widget.selectedPlaylist));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 1.h,
              iconTheme: const IconThemeData(color: Colors.black),
              backgroundColor: Colors.white.withOpacity(.9),
              title: Text(
                widget.selectedPlaylist.title,
                style: GoogleFonts.readexPro(color: Colors.black),
              ),
              floating: true,
              snap: true,
              pinned: true,
            ),
            BlocBuilder<VideoListBloc, VideoListState>(
              builder: (context, state) {
                if (state is VideoListLoading) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      if (index == 0) {
                        return ShimmerImageVideoTitleAndDescription();
                      }
                      return ShimmerVideoListTile();
                    },
                    childCount: 8
                    ),
                  );
                } else if (state is VideoListData) {
                  final videoList = state.videoList;

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      
                      (context, index) {
                        if (index == 0) {
                          return imageVideoTitleAndDescription();
                        } else if (index == 1) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Text(
                              'Videos',
                              style: GoogleFonts.readexPro(
                                fontSize: 16.sp,
                              ),
                            ),
                          );
                        } else {
                          final videoIndex = index - 2;

                          if (videoIndex < videoList.length) {
                            final video = videoList[videoIndex];
                            return VideoListTile(video: video);
                          } else if (videoIndex == videoList.length) {
                            return const SliverToBoxAdapter(
                              child: ListTile(
                                title: Text("End of the list"),
                              ),
                            );
                          }
                        }

                        return const SliverToBoxAdapter();
                      },
                      childCount: videoList.length + 2,
                    ),
                  );
                } else if (state is VideoListError) {
                  return SliverToBoxAdapter(
                    child: ListTile(
                      title: Text('Error occurred: ${state.errorMessage}'),
                    ),
                  );
                }

                return const SliverToBoxAdapter(); // this is the adapter
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget imageVideoTitleAndDescription() {
    return Padding(
      padding: EdgeInsets.only(top: 12.h, left: 16.w, right: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 4.h),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2.r,
                  blurRadius: 5.r,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.network(
                widget.selectedPlaylist.thumbnailUrl,
                height: 184.r,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 12.r),
          Text(
            widget.selectedPlaylist.title,
            style: GoogleFonts.readexPro(
                fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 12.r),
          Text(
            widget.selectedPlaylist.description.isNotEmpty
                ? widget.selectedPlaylist.description
                : "No description",
            maxLines: 3,
            overflow: TextOverflow.fade,
            style: GoogleFonts.outfit(fontSize: 12.sp, color: Colors.black45),
          ),
          const Divider(),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
