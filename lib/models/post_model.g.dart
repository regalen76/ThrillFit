// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      author: json['author'] as String,
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      content:
          (json['content'] as List<dynamic>?)?.map((e) => e as String).toList(),
      body: json['body'] as String,
      timestamp:
          const TimestampConverter().fromJson(json['timestamp'] as Timestamp),
      workoutPlan: json['workout_plan'] as String?,
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'author': instance.author,
      'comments': instance.comments,
      'content': instance.content,
      'body': instance.body,
      'timestamp': const TimestampConverter().toJson(instance.timestamp),
      'workout_plan': instance.workoutPlan,
    };
