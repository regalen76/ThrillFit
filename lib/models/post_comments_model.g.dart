// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_comments_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostCommentsModel _$PostCommentsModelFromJson(Map<String, dynamic> json) =>
    PostCommentsModel(
      comments: json['comments'] as String,
      postId: json['post_id'] as String,
      user: json['user'] as String,
    );

Map<String, dynamic> _$PostCommentsModelToJson(PostCommentsModel instance) =>
    <String, dynamic>{
      'comments': instance.comments,
      'post_id': instance.postId,
      'user': instance.user,
    };
