import 'package:thrill_fit/models/models.dart';

class TrainingSetSelected {
  final String id;
  final String goalTypeId;
  final String? trainingSetName;
  final List<WorkoutMoveSelected>? workoutMoves;
  String? imageGoalType;
  bool selected;

  TrainingSetSelected(
      {required this.id,
      required this.goalTypeId,
      this.trainingSetName,
      this.workoutMoves,
      this.imageGoalType,
      this.selected = false});
}
