import 'package:flutter/material.dart';

import '../../../../models/vid_id_and_list_of_notes_of_that.dart';
import '../../../notes/view/widgets/note_card.dart';

class AllVideoNotesWidget extends StatelessWidget {
  final VidIdAndListOfNotesModal vidIdAndListOfNotesModal;

  const AllVideoNotesWidget({Key? key, required this.vidIdAndListOfNotesModal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        vidIdAndListOfNotesModal.notesOfThisVideoId[0].videoTitle,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [
        SizedBox(
          height: 400,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: vidIdAndListOfNotesModal.notesOfThisVideoId.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: NoteCard(
                  note: vidIdAndListOfNotesModal.notesOfThisVideoId[index],
                  vidId: vidIdAndListOfNotesModal.notesOfThisVideoId[index].videoId,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
