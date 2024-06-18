// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_plan_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutPlanRequestModel _$WorkoutPlanRequestModelFromJson(
        Map<String, dynamic> json) =>
    WorkoutPlanRequestModel(
      userId: json['user_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      repetition: json['repetition'] as int,
      dailyRepetition: json['daily_repetition'] as int,
      lastUpdated: const TimestampConverter()
          .fromJson(json['last_updated'] as Timestamp),
    );

Map<String, dynamic> _$WorkoutPlanRequestModelToJson(
        WorkoutPlanRequestModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'repetition': instance.repetition,
      'daily_repetition': instance.dailyRepetition,
      'last_updated': const TimestampConverter().toJson(instance.lastUpdated),
    };
