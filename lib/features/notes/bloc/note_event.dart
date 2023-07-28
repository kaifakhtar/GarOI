// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadNotes extends NoteEvent {
  //* Load notes
  final String videoId;

  LoadNotes({required this.videoId});

  @override
  List<Object?> get props => [videoId];
}

class AddNote extends NoteEvent {
  //* Add note
  final Note note;

  AddNote({required this.note});

  @override
  List<Object?> get props => [note];
}

class DeleteNote extends NoteEvent {
  final int noteId;
  DeleteNote({
    required this.noteId,
  });
}

class UpdateNote extends NoteEvent {
  final Note updatedNote;
  UpdateNote({
    required this.updatedNote,
  });
}

class ExportNotesToPdf extends NoteEvent {
  final String videoID;
  final String filename;
  ExportNotesToPdf({required this.videoID,required this.filename});
}
