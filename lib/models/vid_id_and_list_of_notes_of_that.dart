import 'note_modal.dart';

class VidIdAndListOfNotesModal {
  final String videoId;
  final List<Note> notesOfThisVideoId;

  VidIdAndListOfNotesModal(
      {required this.videoId, required this.notesOfThisVideoId});

  @override
  String toString() {
    return 'VidIdAndListOfNotes(videoId: $videoId, notesOfThisVideoId: $notesOfThisVideoId)';
  }
}
