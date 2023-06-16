import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ytyt/features/video_list.dart/bloc/video_list_bloc.dart';

class VideoListScreen extends StatefulWidget {
  const VideoListScreen({super.key});

  @override
  State<VideoListScreen> createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
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
            Image.network(""),
            SizedBox(
              height: 24.h,
            ),
            const Text("Video title"),
            SizedBox(
              height: 4.h,
            ),
            const Text("Video description hjty drghjhjyj"),
            const Divider(),
            SizedBox(
              height: 24.h,
            ),
            const Text("Videos"),
            SizedBox(
              child: BlocBuilder<VideoListBloc, VideoListState>(
                builder: (context, state) {
                  if (state is VideoListData) {
                    return ListView.builder(
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return;
                      },
                    );
                  } else if (state is VideoListError) {
                    return const Text("Some error occurred");
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
