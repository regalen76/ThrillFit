import 'package:json_annotation/json_annotation.dart';
part 'workout_move_data.g.dart';

@JsonSerializable()
class WorkoutMoveData {
  final String id;
  @JsonKey(name: 'movement_image')
  final String movementImage;
  @JsonKey(name: 'movement_name')
  final String movementName;
  @JsonKey(name: 'training_set_id')
  final String trainingSetId;

  WorkoutMoveData(
      {required this.id,
      required this.movementImage,
      required this.movementName,
      required this.trainingSetId});

  factory WorkoutMoveData.fromJson(Map<String, dynamic> json) =>
      _$WorkoutMoveDataFromJson(json);
  Map<String, dynamic> toJson() => _$WorkoutMoveDataToJson(this);
}
