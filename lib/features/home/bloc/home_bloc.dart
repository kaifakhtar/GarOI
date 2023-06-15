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
    on<HomeLoadMorePlaylist>(_loadMorePlaylist);
  }

  FutureOr<void> _loadPlaylist(
      HomeLoadPlaylist event, Emitter<HomeState> emit) async {
    emit(HomeLoading());

   List<Playlist> listOfPlaylist= await service.fetchPlaylists(channelId: ChannelConstants.CHANNEL_ID);
 emit(HomeHasData(listOfPlaylist: listOfPlaylist));
 
 }

  FutureOr<void> _loadMorePlaylist(HomeLoadMorePlaylist event, Emitter<HomeState> emit)async {
 if (state is HomeHasData) {
    HomeHasData currentState = state as HomeHasData;
    List<Playlist> existingPlaylist = currentState.listOfPlaylist;

    // Fetch more playlists and store them in a new list
    List<Playlist> playlistMore = await service.fetchPlaylists(channelId: ChannelConstants.CHANNEL_ID);

    // Combine the existing and new playlists
    List<Playlist> updatedPlaylist = [...existingPlaylist, ...playlistMore];

    // Update the state with the new list
    emit(HomeHasData(listOfPlaylist: updatedPlaylist));
  }

  }
}
