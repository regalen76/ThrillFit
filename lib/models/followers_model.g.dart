// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'followers_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowersModel _$FollowersModelFromJson(Map<String, dynamic> json) =>
    FollowersModel(
      follow: json['follow'] as String,
      user: json['user'] as String,
    );

Map<String, dynamic> _$FollowersModelToJson(FollowersModel instance) =>
    <String, dynamic>{
      'follow': instance.follow,
      'user': instance.user,
    };
