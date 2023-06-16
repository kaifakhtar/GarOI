// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'video_list_bloc.dart';

@immutable
abstract class VideoListState {}

class VideoListLoading extends VideoListState {}

class VideoListData extends VideoListState {
  final List<Video> videoList;

  VideoListData({
    required this.videoList,
  });
}

class VideoListError extends VideoListState {
  final String errorMessage;
  VideoListError({
    required this.errorMessage,
  });
}
