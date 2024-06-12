// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_plan_movesets_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutPlanMovesetsData _$WorkoutPlanMovesetsDataFromJson(
        Map<String, dynamic> json) =>
    WorkoutPlanMovesetsData(
      id: json['id'] as String,
      movementName: json['movement_name'] as String,
      movementImage: json['movement_image'] as String,
      viewOrder: json['view_order'] as int,
    );

Map<String, dynamic> _$WorkoutPlanMovesetsDataToJson(
        WorkoutPlanMovesetsData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'movement_name': instance.movementName,
      'movement_image': instance.movementImage,
      'view_order': instance.viewOrder,
    };
