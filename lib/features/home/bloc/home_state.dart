// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeHasData extends HomeState {
  final List<Playlist> listOfPlaylist;
  
  HomeHasData({
    required this.listOfPlaylist,
  });
}
