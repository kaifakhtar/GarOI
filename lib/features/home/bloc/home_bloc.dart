import 'dart:async';


import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:ytyt/utilities/channel.dart';

import '../../../models/channel_model.dart';
import '../../../models/playlistmodal.dart';
import '../services/api_services.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final APIService service;
  HomeBloc({required this.service})
      : super(HomeHasData(listOfPlaylist: [])) {
    on<HomeLoadPlaylist>(_loadPlaylist);
  }

  FutureOr<void> _loadPlaylist(
      HomeLoadPlaylist event, Emitter<HomeState> emit) async {
    emit(HomeLoading());

   List<Playlist> listOfPlaylist= await service.fetchPlaylists(channelId: ChannelConstants.CHANNEL_ID);
 emit(HomeHasData(listOfPlaylist: listOfPlaylist));
 
 }
}
