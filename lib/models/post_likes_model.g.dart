// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_likes_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostLikesModel _$PostLikesModelFromJson(Map<String, dynamic> json) =>
    PostLikesModel(
      postId: json['post_id'] as String,
      user: json['user'] as String,
    );

Map<String, dynamic> _$PostLikesModelToJson(PostLikesModel instance) =>
    <String, dynamic>{
      'post_id': instance.postId,
      'user': instance.user,
    };
