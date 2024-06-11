import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thrill_fit/shared/timestamp_converter.dart';

part 'insert_workout_plan_model.g.dart';

@JsonSerializable()
class InsertWorkoutPlanModel {
  @JsonKey(name: 'user_id')
  final String userId;
  final String title;
  final String description;
  final int frequency;
  @TimestampConverter()
  @JsonKey(name: 'last_updated')
  final DateTime lastUpdated;

  InsertWorkoutPlanModel(
      {required this.userId,
      required this.title,
      required this.description,
      required this.frequency,
      required this.lastUpdated});

  factory InsertWorkoutPlanModel.fromJson(Map<String, dynamic> json) =>
      _$InsertWorkoutPlanModelFromJson(json);
  Map<String, dynamic> toJson() => _$InsertWorkoutPlanModelToJson(this);
}
