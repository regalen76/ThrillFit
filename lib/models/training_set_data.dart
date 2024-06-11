import 'package:json_annotation/json_annotation.dart';
part 'training_set_data.g.dart';

@JsonSerializable()
class TrainingSetData {
  final String id;
  @JsonKey(name: 'goal_type_id')
  final String goalTypeId;
  @JsonKey(name: 'training_set_name')
  final String trainingSetName;

  TrainingSetData(
      {required this.id,
      required this.goalTypeId,
      required this.trainingSetName});

  factory TrainingSetData.fromJson(Map<String, dynamic> json) =>
      _$TrainingSetDataFromJson(json);
  Map<String, dynamic> toJson() => _$TrainingSetDataToJson(this);
}
