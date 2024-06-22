import 'package:json_annotation/json_annotation.dart';
part 'workout_plans_data.g.dart';

@JsonSerializable()
class WorkoutPlansData {
  final String id;
  @JsonKey(name: 'user_id')
  final String userId;
  final String title;
  final String description;
  final int repetition;
  @JsonKey(name: 'daily_repetition')
  final int dailyRepetition;
  @JsonKey(name: 'last_updated')
  final DateTime lastUpdated;

  WorkoutPlansData({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.repetition,
    required this.dailyRepetition,
    required this.lastUpdated,
  });

  factory WorkoutPlansData.fromJson(Map<String, dynamic> json) =>
      _$WorkoutPlansDataFromJson(json);
  Map<String, dynamic> toJson() => _$WorkoutPlansDataToJson(this);
}
