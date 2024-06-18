import 'package:json_annotation/json_annotation.dart';
part 'workout_plan_movesets_data.g.dart';

@JsonSerializable()
class WorkoutPlanMovesetsData {
  final String id;
  @JsonKey(name: 'movement_id')
  final String movementId;
  @JsonKey(name: 'view_order')
  final int viewOrder;

  WorkoutPlanMovesetsData({
    required this.id,
    required this.movementId,
    required this.viewOrder,
  });

  factory WorkoutPlanMovesetsData.fromJson(Map<String, dynamic> json) =>
      _$WorkoutPlanMovesetsDataFromJson(json);
  Map<String, dynamic> toJson() => _$WorkoutPlanMovesetsDataToJson(this);
}
