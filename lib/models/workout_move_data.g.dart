// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_move_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutMoveData _$WorkoutMoveDataFromJson(Map<String, dynamic> json) =>
    WorkoutMoveData(
      id: json['id'] as String,
      movementImage: json['movement_image'] as String,
      movementName: json['movement_name'] as String,
      trainingSetId: json['training_set_id'] as String,
    );

Map<String, dynamic> _$WorkoutMoveDataToJson(WorkoutMoveData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'movement_image': instance.movementImage,
      'movement_name': instance.movementName,
      'training_set_id': instance.trainingSetId,
    };
