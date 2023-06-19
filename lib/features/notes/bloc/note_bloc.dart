import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../models/note_modal.dart';
import '../note_service/note_service.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteDataBaseService noteDataBaseService;

  NoteBloc({required this.noteDataBaseService}) : super(NoteInitial()) {
    on<LoadNotes>(_loadNotes);
    on<AddNote>(_addNote);
    on<DeleteNote>(_deleteNote);
     on<UpdateNote>(_updateNote);
  
  }

  FutureOr<void> _loadNotes(LoadNotes event, Emitter<NoteState> emit) async {
    emit(NoteLoading());
    try {
      List<Note> fetchedNotes =
          await noteDataBaseService.getNotesForVideo(event.videoId);
      print(fetchedNotes.length);
      if (fetchedNotes.isNotEmpty) {
        print(fetchedNotes.length);
        emit(NoteLoaded(notes: fetchedNotes));
      } else {
        emit(NoNotes());
      }
    } catch (e) {
      print("Error:${e.toString}");
    }
  }

  FutureOr<void> _addNote(AddNote event, Emitter<NoteState> emit) {
    emit(NoteLoading());
    try {
      noteDataBaseService.insertNoteForVideo(event.note);
      emit(NoteAdded());
    } catch (e) {
      print("Error:${e.toString}");
    }
  }

  FutureOr<void> _deleteNote(DeleteNote event, Emitter<NoteState> emit) {
    emit(NoteLoading());
    try {
      noteDataBaseService.deleteNote(event.noteId);
      emit(NoteSuccess(message: "Successfully deleted"));
    } catch (e) {
      emit(NoteError(message: "Some error happened while deleting"));
    }
  }
    FutureOr<void> _updateNote(UpdateNote event, Emitter<NoteState> emit) {
    emit(NoteLoading());
    try {
      noteDataBaseService.updateNote(event.updatedNote);
      emit(NoteSuccess(message: "Done updating"));
    } catch (e) {
      emit(NoteError(message: "Something error happened while updating"));
    }
  }
}
