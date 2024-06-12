import 'package:json_annotation/json_annotation.dart';
part 'workout_plan_movesets_data.g.dart';

@JsonSerializable()
class WorkoutPlanMovesetsData {
  final String id;
  @JsonKey(name: 'movement_name')
  final String movementName;
  @JsonKey(name: 'movement_image')
  final String movementImage;
  @JsonKey(name: 'view_order')
  final int viewOrder;

  WorkoutPlanMovesetsData({
    required this.id,
    required this.movementName,
    required this.movementImage,
    required this.viewOrder,
  });

  factory WorkoutPlanMovesetsData.fromJson(Map<String, dynamic> json) =>
      _$WorkoutPlanMovesetsDataFromJson(json);
  Map<String, dynamic> toJson() => _$WorkoutPlanMovesetsDataToJson(this);
}
