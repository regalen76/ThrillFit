import 'package:json_annotation/json_annotation.dart';
part 'insert_workout_plan_move_model.g.dart';

@JsonSerializable()
class InsertWorkoutPlanMoveModel {
  @JsonKey(name: 'workout_plan_id')
  final String workoutPlanId;
  @JsonKey(name: 'movement_name')
  final String movementName;
  @JsonKey(name: 'movement_image')
  final String movementImage;
  @JsonKey(name: 'view_order')
  final int viewOrder;

  InsertWorkoutPlanMoveModel({
    required this.workoutPlanId,
    required this.movementName,
    required this.movementImage,
    required this.viewOrder,
  });

  factory InsertWorkoutPlanMoveModel.fromJson(Map<String, dynamic> json) =>
      _$InsertWorkoutPlanMoveModelFromJson(json);
  Map<String, dynamic> toJson() => _$InsertWorkoutPlanMoveModelToJson(this);
}
