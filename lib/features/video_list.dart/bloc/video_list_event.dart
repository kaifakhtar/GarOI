// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'video_list_bloc.dart';

@immutable
abstract class VideoListEvent {}

class VideoListFetch extends VideoListEvent {
  final Playlist selectedPlaylist;
  
  VideoListFetch({
    required this.selectedPlaylist,
  });
}
class VideoListReset extends VideoListEvent {}