import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thrill_fit/shared/timestamp_converter.dart';

part 'workout_plan_request_model.g.dart';

@JsonSerializable()
class WorkoutPlanRequestModel {
  @JsonKey(name: 'user_id')
  final String userId;
  final String title;
  final String description;
  final int repetition;
  @JsonKey(name: 'daily_repetition')
  final int dailyRepetition;
  @TimestampConverter()
  @JsonKey(name: 'last_updated')
  final DateTime lastUpdated;

  WorkoutPlanRequestModel(
      {required this.userId,
      required this.title,
      required this.description,
      required this.repetition,
      required this.dailyRepetition,
      required this.lastUpdated});

  factory WorkoutPlanRequestModel.fromJson(Map<String, dynamic> json) =>
      _$WorkoutPlanRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$WorkoutPlanRequestModelToJson(this);
}
