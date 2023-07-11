import 'package:bloc/bloc.dart';

import 'package:ytyt/features/notes/note_service/note_service.dart';

import '../../../models/note_modal.dart';
import '../../../models/vid_id_and_list_of_notes_of_that.dart';

part 'all_note_state.dart';

class AllNoteCubit extends Cubit<AllNotesState> {
  AllNoteCubit() : super(AllNotesLoading());

  Future<void> getVidIdsAndNotesOfThat() async {
    emit(AllNotesLoading());
    final noteDataBaseService = NoteDataBaseService();
    List<VidIdAndListOfNotesModal> vidIdAndListOfNotes = [];
    try {
      List<String> vidIdsFromNotesTable =
          await noteDataBaseService.getAllDistinctVideoIdsFromNotesTable();
      for (var vidId in vidIdsFromNotesTable) {
        List<Note> notesOfThisVidId =
            await noteDataBaseService.getNotesForVideo(vidId);
        final vidIdAndListOfNotesModal = VidIdAndListOfNotesModal(
            videoId: vidId, notesOfThisVideoId: notesOfThisVidId);
        vidIdAndListOfNotes.add(vidIdAndListOfNotesModal);
        print(vidIdAndListOfNotes.toString());
      }

      if (vidIdAndListOfNotes.isEmpty) {
        emit(AllNotesNoNotes());
      } else {
        emit(AllNotesLoadingSuccess(vidIdAndListOfNotes));
      }
    } catch (err) {
      print(err.toString());
      emit(AllNotesLoadingError(errorMessage: err.toString()));
    }
  }
}
