// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import 'package:ytyt/features/notes/bloc/note_bloc.dart';
import 'package:ytyt/models/note_modal.dart';

class NoteScreen extends StatefulWidget {
  final String videoId;
  const NoteScreen({
    Key? key,
    required this.videoId,
  }) : super(key: key);
  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  late final NoteBloc noteBloc;
  final TextEditingController _descriptionController = TextEditingController();
  int countWords(String text) {
    if (text.isEmpty) {
      return 0;
    }

    // Split the string into words using whitespace as the delimiter
    List<String> words = text.trim().split(' ');

    // Remove empty strings from the list (e.g., consecutive whitespaces)
    words.removeWhere((word) => word.isEmpty);

    return words.length;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    noteBloc = BlocProvider.of<NoteBloc>(context);
    
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        noteBloc.add(LoadNotes(videoId: widget.videoId));
        // Handle back button press
        // Return true to allow popping the screen, or false to prevent it
        return true; // You can customize the behavior here
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Note'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _descriptionController,
                maxLines: 8,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Save note logic
                  String title = _titleController.text;
                  String description = _descriptionController.text;
                  Note note = Note(
                      title: title,
                      description: description,
                      videoId: widget.videoId,
                      words: countWords(description),
                      timestamp: DateTime.now());

                  noteBloc.add(AddNote(note: note));
                  // Perform necessary actions with the note data
                  print('Title: $title');
                  print('Description: $description');
                },
                child: BlocBuilder<NoteBloc, NoteState>(
                  builder: (context, state) {
                    if (state is NoteLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is NoteAdded) {
                      return const Icon(Iconsax.tick_circle);
                    }
                    return const Text('Save');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
