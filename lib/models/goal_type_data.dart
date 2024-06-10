import 'package:json_annotation/json_annotation.dart';
part 'goal_type_data.g.dart';

@JsonSerializable()
class GoalTypeData {
  final String id;
  @JsonKey(name: 'goal_type_name')
  final String goalTypeName;
  @JsonKey(name: 'goal_type_image')
  final String goalTypeImage;

  GoalTypeData(
      {required this.id,
      required this.goalTypeName,
      required this.goalTypeImage});

  factory GoalTypeData.fromJson(Map<String, dynamic> json) =>
      _$GoalTypeDataFromJson(json);
  Map<String, dynamic> toJson() => _$GoalTypeDataToJson(this);
}
