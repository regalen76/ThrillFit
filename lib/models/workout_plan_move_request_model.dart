import 'package:json_annotation/json_annotation.dart';
part 'workout_plan_move_request_model.g.dart';

@JsonSerializable()
class WorkoutPlanMoveRequestModel {
  @JsonKey(name: 'workout_plan_id')
  final String workoutPlanId;
  @JsonKey(name: 'movement_name')
  final String movementName;
  @JsonKey(name: 'movement_image')
  final String movementImage;
  @JsonKey(name: 'view_order')
  final int viewOrder;

  WorkoutPlanMoveRequestModel({
    required this.workoutPlanId,
    required this.movementName,
    required this.movementImage,
    required this.viewOrder,
  });

  factory WorkoutPlanMoveRequestModel.fromJson(Map<String, dynamic> json) =>
      _$WorkoutPlanMoveRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$WorkoutPlanMoveRequestModelToJson(this);
}
