// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
    if (text.isEmpty || text.trim().isEmpty) {
      return 0;
    }

    // Split the text into words using whitespace, line breaks, and punctuation marks as delimiters
    final words = text
        .trim()
        .split(RegExp(r'\s+|\n|(?<=\w)(?=[^\w\s])|(?<=[^\w\s])(?=\w)'));

    // Remove any empty strings from the list of words
    final filteredWords = words.where((word) => word.isNotEmpty);

    // Return the count of words
    return filteredWords.length;
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
          backgroundColor: const Color(0xFFFFF7D4),
          //resizeToAvoidBottomInset: false,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            elevation: 0,
            title: Text(
              'Add note',
              style: GoogleFonts.readexPro(color: Colors.black),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(16.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Title...",
                      hintStyle: GoogleFonts.outfit(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),

                      // labelText: 'Title',
                    ),
                    style: GoogleFonts.outfit(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                        //  labelText: 'Description',
                        hintStyle: GoogleFonts.outfit(fontSize: 16.sp),
                        border: InputBorder.none,
                        // hintText: "...",
                        hintText: "Write the description and be concise..."),

                    style: GoogleFonts.outfit(fontSize: 16.sp),
                    maxLines: 20,
                    // Allows the text field to grow dynamically
                    keyboardType: TextInputType.multiline,
                    scrollPhysics: const BouncingScrollPhysics(),
                  ),
                  SizedBox(height: 16.h),
                  // ElevatedButton(
                  //   onPressed: isButtonEnabled
                  //       ? () {
                  //           // Save note logic
                  //           String title = _titleController.text;
                  //           String description = _descriptionController.text;
                  //           Note note = Note(
                  //               title: title,
                  //               description: description,
                  //               videoId: widget.videoId,
                  //               words: countWords(description),
                  //               timestamp: DateTime.now());

                  //           noteBloc.add(AddNote(note: note));

                  //           // Perform necessary actions with the note data
                  //           print(note.toString());
                  //         }
                  //       : null,
                  //   child: BlocBuilder<NoteBloc  , NoteState>(
                  //     builder: (context, state) {
                  //       if (state is NoteLoading) {
                  //          print("Note loading state");
                  //         return const CircularProgressIndicator();
                  //       }  if (state is NoteAdded) {
                  //         print("Note added state");
                  //         isButtonEnabled = false;

                  //         return const Icon(Iconsax.tick_circle);
                  //       }
                  //       return const Text('Save');
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: null,
            onPressed: () {
              // Save note logic
              String title = _titleController.text;
              String description = _descriptionController.text;
              if (title.isNotEmpty || description.isNotEmpty) {
                Note note = Note(
                    title: title.isEmpty?"Untitled":title,
                    description:description.isEmpty?"No description":description,
                    videoId: widget.videoId,
                    words: countWords(description),
                    timestamp: DateTime.now());

                noteBloc.add(AddNote(note: note));
              }

              // Perform necessary actions with the note da
            },
            child: const Icon(Iconsax.tick_circle),
          ),
        ),
      ),
    );
  }
}
