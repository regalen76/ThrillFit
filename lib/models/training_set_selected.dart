import 'package:thrill_fit/models/models.dart';

class TrainingSetSelected {
  final String id;
  final String? trainingSetName;
  final String? imageType;
  final List<WorkoutMove>? workoutMoves;
  bool selected;

  TrainingSetSelected(
      {required this.id,
      this.trainingSetName,
      this.imageType,
      this.workoutMoves,
      this.selected = false});
}
