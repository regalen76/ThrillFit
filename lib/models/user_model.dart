import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final int age;
  @JsonKey(name: 'challenge_wins')
  final int challengeWins;
  @JsonKey(name: 'consecutive_workout')
  final int concecutiveWorkout;
  final String email;
  final int followers;
  final String gender;
  final int height;
  final String name;
  @JsonKey(name: 'name_search')
  final List<String> nameSearch;
  final String phone;
  final int weight;

  UserModel(
      {required this.age,
      required this.challengeWins,
      required this.concecutiveWorkout,
      required this.email,
      required this.followers,
      required this.gender,
      required this.height,
      required this.name,
      required this.nameSearch,
      required this.phone,
      required this.weight});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
