import 'package:flutter/material.dart';

import '../../../../models/vid_id_and_list_of_notes_of_that.dart';
import '../../../notes/view/widgets/note_card.dart';

class AllVideoNotesWidget extends StatelessWidget {
  // final String videoTitle;
  // final List<NoteCard> noteCards;
  final VidIdAndListOfNotesModal vidIdAndListOfNotesModal;

  const AllVideoNotesWidget({super.key, required this.vidIdAndListOfNotesModal});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              vidIdAndListOfNotesModal.notesOfThisVideoId[0].videoTitle,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 400,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: vidIdAndListOfNotesModal.notesOfThisVideoId.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: NoteCard(note: vidIdAndListOfNotesModal.notesOfThisVideoId[index], vidId: vidIdAndListOfNotesModal.notesOfThisVideoId[index].videoId,),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
