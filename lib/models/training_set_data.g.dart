// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_set_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrainingSetData _$TrainingSetDataFromJson(Map<String, dynamic> json) =>
    TrainingSetData(
      id: json['id'] as String,
      goalTypeId: json['goal_type_id'] as String,
      trainingSetName: json['training_set_name'] as String,
    );

Map<String, dynamic> _$TrainingSetDataToJson(TrainingSetData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'goal_type_id': instance.goalTypeId,
      'training_set_name': instance.trainingSetName,
    };
