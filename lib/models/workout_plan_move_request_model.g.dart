// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_plan_move_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutPlanMoveRequestModel _$WorkoutPlanMoveRequestModelFromJson(
        Map<String, dynamic> json) =>
    WorkoutPlanMoveRequestModel(
      workoutPlanId: json['workout_plan_id'] as String,
      movementId: json['movement_id'] as String,
      viewOrder: json['view_order'] as int,
    );

Map<String, dynamic> _$WorkoutPlanMoveRequestModelToJson(
        WorkoutPlanMoveRequestModel instance) =>
    <String, dynamic>{
      'workout_plan_id': instance.workoutPlanId,
      'movement_id': instance.movementId,
      'view_order': instance.viewOrder,
    };
