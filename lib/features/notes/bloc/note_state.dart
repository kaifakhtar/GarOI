part of 'note_bloc.dart';

@immutable
abstract class NoteState extends Equatable {}

class NoteInitial extends NoteState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NoteLoading extends NoteState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NoteLoaded extends NoteState {
  final List<Note> notes;

  NoteLoaded({required this.notes});

  @override
  List<Object?> get props => [notes];
}

class NoteError extends NoteState {
  final String message;

  NoteError({required this.message});

  @override
  List<Object?> get props => [message];
}

class NoteAdded extends NoteState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NoteAddError extends NoteState {
  final String message;

  NoteAddError({required this.message});

  @override
  List<Object?> get props => [message];
}

class NoNotes extends NoteState {
  @override
  // TODO: implement props
  List<Object?> get props =>[];
}
class NoteSuccess extends NoteState {
  final String message;

  NoteSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}