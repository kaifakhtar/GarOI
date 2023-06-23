// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  bool isButtonEnabled = true;
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
    return Hero(
      tag: 'addnote',
      child: WillPopScope(
        onWillPop: () async {
          noteBloc.add(LoadNotes(videoId: widget.videoId));
          // Handle back button press
          // Return true to allow popping the screen, or false to prevent it
          return true; // You can customize the behavior here
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text('Add note'),
          ),
          body: Padding(
            padding: EdgeInsets.all(16.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Title',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _descriptionController,
                    maxLines: 20,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Description',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: isButtonEnabled
                        ? () {
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
                            print(note.toString());
                          }
                        : null,
                    child: BlocBuilder<NoteBloc  , NoteState>(
                      builder: (context, state) {
                        if (state is NoteLoading) {
                           print("Note loading state");
                          return const CircularProgressIndicator();
                        }  if (state is NoteAdded) {
                          print("Note added state");
                          isButtonEnabled = false;
                    
                       
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
        ),
      ),
    );
  }
}