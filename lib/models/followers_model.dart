import 'package:json_annotation/json_annotation.dart';

part 'followers_model.g.dart';

@JsonSerializable()
class FollowersModel {
  final String follow;
  final String user;

  FollowersModel({required this.follow, required this.user});

  factory FollowersModel.fromJson(Map<String, dynamic> json) =>
      _$FollowersModelFromJson(json);
  Map<String, dynamic> toJson() => _$FollowersModelToJson(this);
}
