import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/playlistmodal.dart';
import '../../../models/video_model.dart';
import '../../home/services/api_services.dart';

part 'video_list_event.dart';
part 'video_list_state.dart';

class VideoListBloc extends Bloc<VideoListEvent, VideoListState> {
  final APIService service;

  VideoListBloc({required this.service}) : super(VideoListData(videoList: [])) {
    on<VideoListFetch>(_fetchVideoList);
    on<VideoListReset>(_resetVideoList);
  }

  FutureOr<void> _fetchVideoList(
      VideoListFetch event, Emitter<VideoListState> emit) async {
    emit(VideoListLoading());

    try {
      List<Video> listOfVideoFromPlaylist = await service
          .fetchVideosFromPlaylist(playlistId: event.selectedPlaylist.id);
      emit(VideoListData(videoList: listOfVideoFromPlaylist));
    } catch (err) {
      emit(VideoListError(errorMessage: err.toString()));
    }
  }

  void _resetVideoList(VideoListReset event, Emitter<VideoListState> emit) {
    emit(VideoListData(videoList: []));
  }
}
