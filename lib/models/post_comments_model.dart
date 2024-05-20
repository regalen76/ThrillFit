import 'package:json_annotation/json_annotation.dart';
part 'post_comments_model.g.dart';

@JsonSerializable()
class PostCommentsModel {
  final String comments;
  @JsonKey(name: 'post_id')
  final String postId;
  final String user;

  PostCommentsModel(
      {required this.comments, required this.postId, required this.user});

  factory PostCommentsModel.fromJson(Map<String, dynamic> json) =>
      _$PostCommentsModelFromJson(json);
  Map<String, dynamic> toJson() => _$PostCommentsModelToJson(this);
}
