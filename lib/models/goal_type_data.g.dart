// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_type_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoalTypeData _$GoalTypeDataFromJson(Map<String, dynamic> json) => GoalTypeData(
      id: json['id'] as String,
      goalTypeName: json['goal_type_name'] as String,
      goalTypeImage: json['goal_type_image'] as String,
    );

Map<String, dynamic> _$GoalTypeDataToJson(GoalTypeData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'goal_type_name': instance.goalTypeName,
      'goal_type_image': instance.goalTypeImage,
    };
