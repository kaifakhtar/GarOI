import 'package:flutter/material.dart';

class NoteScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
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
                  // Perform necessary actions with the note data
                  print('Title: $title');
                  print('Description: $description');
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}