// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_plans_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutPlansData _$WorkoutPlansDataFromJson(Map<String, dynamic> json) =>
    WorkoutPlansData(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      repetition: json['repetition'] as int,
      dailyRepetition: json['daily_repetition'] as int,
    );

Map<String, dynamic> _$WorkoutPlansDataToJson(WorkoutPlansData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'repetition': instance.repetition,
      'daily_repetition': instance.dailyRepetition,
    };
