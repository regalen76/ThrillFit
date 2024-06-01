import 'package:json_annotation/json_annotation.dart';
part 'post_likes_model.g.dart';

@JsonSerializable()
class PostLikesModel {
  @JsonKey(name: 'post_id')
  final String postId;
  final String user;

  PostLikesModel({required this.postId, required this.user});

  factory PostLikesModel.fromJson(Map<String, dynamic> json) =>
      _$PostLikesModelFromJson(json);
  Map<String, dynamic> toJson() => _$PostLikesModelToJson(this);
}
