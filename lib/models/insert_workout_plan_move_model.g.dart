// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_workout_plan_move_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertWorkoutPlanMoveModel _$InsertWorkoutPlanMoveModelFromJson(
        Map<String, dynamic> json) =>
    InsertWorkoutPlanMoveModel(
      workoutPlanId: json['workout_plan_id'] as String,
      movementName: json['movement_name'] as String,
      movementImage: json['movement_image'] as String,
      viewOrder: json['view_order'] as int,
    );

Map<String, dynamic> _$InsertWorkoutPlanMoveModelToJson(
        InsertWorkoutPlanMoveModel instance) =>
    <String, dynamic>{
      'workout_plan_id': instance.workoutPlanId,
      'movement_name': instance.movementName,
      'movement_image': instance.movementImage,
      'view_order': instance.viewOrder,
    };
