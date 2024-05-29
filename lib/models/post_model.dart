import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:thrill_fit/shared/timestamp_converter.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel {
  final String author;
  final List<String>? content;
  final String body;
  @TimestampConverter()
  final DateTime timestamp;
  @JsonKey(name: 'workout_plan')
  final String? workoutPlan;

  PostModel(
      {required this.author,
      required this.content,
      required this.body,
      required this.timestamp,
      required this.workoutPlan});

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}
