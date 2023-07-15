// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import 'package:ytyt/features/notes/bloc/note_bloc.dart';
import 'package:ytyt/models/note_modal.dart';

class UpdateNoteScreen extends StatefulWidget {
  final String videoId;
  final Note oldNote;
  const UpdateNoteScreen({
    Key? key,
    required this.videoId,
    required this.oldNote,
  }) : super(key: key);
  @override
  State<UpdateNoteScreen> createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends State<UpdateNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  late final NoteBloc noteBloc;
  bool isButtonEnabled = true;
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
    _titleController.text = widget.oldNote.title;
    _descriptionController.text = widget.oldNote.description;
    noteBloc = BlocProvider.of<NoteBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // noteBloc.add(LoadNotes(videoId: widget.videoId));
        // Handle back button press
        // Return true to allow popping the screen, or false to prevent it
        return true; // You can customize the behavior here
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF7D4),
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title:  Text('Update note',
          style: GoogleFonts.readexPro(),),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  //labelText: 'Title',
                ),
              ),
              SizedBox(height: 16.h),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  //  labelText: 'Description',

                  border: InputBorder.none,
                  // hintText: "...",
                ),

                style: GoogleFonts.lato(fontSize: 16.sp),
                maxLines: null,

                // Allows the text field to grow dynamically
                keyboardType: TextInputType.multiline,
                scrollPhysics: const BouncingScrollPhysics(),
              ),
              SizedBox(height: 16.h),
              // ElevatedButton(
              //   onPressed: () {
              //     // Save note logic
              //     // String updatedTitle = _titleController.text;
              //     // String updatedDescription = _descriptionController.text;
              //     // Note updatedNote = Note(
              //     //     id: widget.oldNote.id,
              //     //     title: updatedTitle,
              //     //     description: updatedDescription,
              //     //     videoId: widget.videoId,
              //     //     videoTitle: widget.oldNote.videoTitle,
              //     //     words: countWords(updatedDescription),
              //     //     timestamp: widget.oldNote.timestamp);

              //     // noteBloc.add(UpdateNote(updatedNote: updatedNote));
              //     // noteBloc.add(LoadNotes(videoId: widget.videoId));
              //     // // Perform necessary actions with the note data
              //     // print(updatedNote.toString());
              //   },
              //   // child: BlocBuilder<NoteBloc, NoteState>(
              //   //   builder: (context, state) {
              //   //     if (state is NoteLoading) {
              //   //       return const CircularProgressIndicator();
              //   //     } else if (state is NoteAdded) {
              //   //       return const Icon(Iconsax.tick_circle);
              //   //     }
              //   //     return const Text('Save');
              //   //   },
              //   // ),
              // ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            String updatedTitle = _titleController.text;
            String updatedDescription = _descriptionController.text;
            Note updatedNote = Note(
                id: widget.oldNote.id,
                title: updatedTitle,
                description: updatedDescription,
                videoId: widget.videoId,
                videoTitle: widget.oldNote.videoTitle,
                words: countWords(updatedDescription),
                timestamp: widget.oldNote.timestamp);

            noteBloc.add(UpdateNote(updatedNote: updatedNote));
            noteBloc.add(LoadNotes(videoId: widget.videoId));
            // Perform necessary actions with the note data
            print(updatedNote.toString());
          },
          child: BlocBuilder<NoteBloc, NoteState>(
            builder: (context, state) {
              if (state is NoteLoading) {
                return const CircularProgressIndicator();
              } else if (state is NoteAdded) {
                return const Icon(Iconsax.tick_circle);
              }
              return const Icon(Iconsax.tick_circle);
            },
          ),
        ),
      ),
    );
  }
}
