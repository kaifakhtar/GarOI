

import 'package:flutter/material.dart';

@immutable
class Note {
 final int? id;
 final String videoId;
 final String title;
 final String description;
 final int words;
 final DateTime timestamp;

  const Note({
     this.id,
    required this.videoId,
    required this.title,
    required this.description,
    required this.words,
    required this.timestamp,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['note_id'],
      videoId: json['video_id'],
      title: json['note_title'],
      description: json['note_description'],
      words: json['note_words'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'note_id': id,
      'video_id': videoId,
      'note_title': title,
      'note_description':description,
      'note_words': words,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['note_id'],
      videoId: map['video_id'],
      title: map['note_title'],
      description: map['note_description'],
      words: map['note_words'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'note_id': id,
      'video_id': videoId,
      'note_title': title,
      'note_description': description,
      'note_words': words,
      'timestamp': timestamp.toIso8601String(),
    };
  }


  Note copyWith({
   int ?id,
  String ?videoId,
  String? title,
  String? description,
  int ?words,
  DateTime? timestamp,
  }) {
    return Note(
      id: id ?? this.id,
      videoId: videoId ?? this.videoId,
      title: title ?? this.title,
      description: description?? this.description,
      words: words ?? this.words,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
