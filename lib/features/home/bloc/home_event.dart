part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeLoadPlaylist extends HomeEvent {}

class HomeLoadMorePlaylist extends HomeEvent {}
