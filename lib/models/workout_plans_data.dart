import 'package:json_annotation/json_annotation.dart';
part 'workout_plans_data.g.dart';

@JsonSerializable()
class WorkoutPlansData {
  final String id;
  final String title;
  final String description;
  final int repetition;
  @JsonKey(name: 'daily_repetition')
  final int dailyRepetition;

  WorkoutPlansData({
    required this.id,
    required this.title,
    required this.description,
    required this.repetition,
    required this.dailyRepetition,
  });

  factory WorkoutPlansData.fromJson(Map<String, dynamic> json) =>
      _$WorkoutPlansDataFromJson(json);
  Map<String, dynamic> toJson() => _$WorkoutPlansDataToJson(this);
}
