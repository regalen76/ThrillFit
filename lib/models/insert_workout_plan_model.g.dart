// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_workout_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertWorkoutPlanModel _$InsertWorkoutPlanModelFromJson(
        Map<String, dynamic> json) =>
    InsertWorkoutPlanModel(
      userId: json['user_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      repetition: json['repetition'] as int,
      dailyRepetition: json['daily_repetition'] as int,
      lastUpdated: const TimestampConverter()
          .fromJson(json['last_updated'] as Timestamp),
    );

Map<String, dynamic> _$InsertWorkoutPlanModelToJson(
        InsertWorkoutPlanModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'repetition': instance.repetition,
      'daily_repetition': instance.dailyRepetition,
      'last_updated': const TimestampConverter().toJson(instance.lastUpdated),
    };