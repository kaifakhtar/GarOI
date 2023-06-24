// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_modal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Student _$$_StudentFromJson(Map<String, dynamic> json) => _$_Student(
      uid: json['uid'] as String,
      username: json['username'] as String,
      streak: json['streak'] as int?,
      ilmPoints: json['ilmPoints'] as int?,
    );

Map<String, dynamic> _$$_StudentToJson(_$_Student instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'username': instance.username,
      'streak': instance.streak,
      'ilmPoints': instance.ilmPoints,
    };
