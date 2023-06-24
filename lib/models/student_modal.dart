import 'package:freezed_annotation/freezed_annotation.dart';

part 'student_modal.freezed.dart';
part 'student_modal.g.dart';
@freezed
class Student with _$Student {
  const factory Student({
    required String uid,
    required String username, 
    int? streak, // number of videos watched in a day
    int? ilmPoints, //calculated based on the length of the video and the number of words of notes
}) = _Student;

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);
}