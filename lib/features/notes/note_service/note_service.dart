import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../../models/note_modal.dart';

const String tableVideos = 'videos';
const String columnVideoId = 'video_id';
const String columnVideoName = 'video_name';
const String columnVideoDuration = 'video_duration';

const String tableNotes = 'notes';
const String columnNoteId = 'note_id';
const String columnNoteVideoId = 'video_id';
const String columnNoteTitle = 'note_title';
const String columnNoteDescription = 'note_description';
const String columnNoteWords = 'note_words';
const String columnNoteTimestamp = 'timestamp';
const String columnNoteVideoTitle = 'note_video_title'; // New column for video title

class NoteDataBaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    // If _database is null, initialize it
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    // Get the path to the database file
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'notes_database.db');

    // Open/create the database at a given path
    return await openDatabase(
      path,
      version: 1, // Set the version number to 1
      onCreate: (Database db, int version) async {
        // Create the videos table
        await db.execute('''
          CREATE TABLE $tableVideos (
            $columnVideoId TEXT PRIMARY KEY,
            $columnVideoName TEXT,
            $columnVideoDuration INTEGER
          )
        ''');

        // Create the notes table
        await db.execute('''
          CREATE TABLE $tableNotes (
            $columnNoteId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnNoteVideoId INTEGER,
            $columnNoteTitle TEXT,
            $columnNoteDescription TEXT,
            $columnNoteWords INTEGER,
            $columnNoteTimestamp TEXT,
            $columnNoteVideoTitle TEXT,
            FOREIGN KEY ($columnNoteVideoId) REFERENCES $tableVideos($columnVideoId)
          )
        ''');
      },
    );
  }

  // Example method to insert a new note for a video
  Future<void> insertNoteForVideo(Note note) async {
    Database db = await database;

    try {
      await db.insert(tableNotes, {
        columnNoteVideoId: note.videoId,
        columnNoteTitle: note.title,
        columnNoteDescription: note.description,
        columnNoteWords: note.words,
        columnNoteVideoTitle:note.videoTitle,
        columnNoteTimestamp: DateTime.now().toIso8601String(),
      });
    } catch (err) {
      throw err;
    }
  }

  // Example method to retrieve all notes for a particular video
  Future<List<Note>> getNotesForVideo(String videoId) async {
    Database db = await database;
     if(kDebugMode)print("inside getNotes for video service");
    final listofNotesMap = await db.query(
      tableNotes,
      where: '$columnNoteVideoId = ?',
      whereArgs: [videoId],
    );

    List<Note> notes = [];
    for (var noteMap in listofNotesMap) {
      Note note = Note.fromJson(noteMap);
      notes.add(note);
    }
    return notes;
  }

  // Example method to retrieve all videos
  Future<List<Map<String, dynamic>>> getAllVideos() async {
    Database db = await database;

    return await db.query(tableVideos);
  }


  // Update a note
  Future<void> updateNote(Note note) async {
    Database db = await database;

    await db.update(
      tableNotes,
      note.toJson(),
      where: '$columnNoteId = ?',
      whereArgs: [note.id],
    );
  }

  // Delete a note
  Future<void> deleteNote(int noteId) async {
    Database db = await database;

    await db.delete(
      tableNotes,
      where: '$columnNoteId = ?',
      whereArgs: [noteId],
    );
  }

//  Future<bool> checkNoteExists(Note note) async {
// Database db = await database;

//     final List<Map<String, dynamic>> result = await db.query(
//       'notes',
//       where: 'note_id = ?',
//       whereArgs: [note.id],
//     );

//     return result.isNotEmpty;
//   }


Future<List<String>> getAllDistinctVideoIdsFromNotesTable() async {
  Database db = await database;
  
  final List<Map<String, dynamic>> result = await db.rawQuery('SELECT DISTINCT $columnNoteVideoId FROM $tableNotes');
  
  List<String> videoIdsFromNotesTable = [];
  for (var row in result) {
    String videoId = row[columnVideoId] as String;
    videoIdsFromNotesTable.add(videoId);
  }
  
  return videoIdsFromNotesTable;
}


}
