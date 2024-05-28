import 'package:thrill_fit/models/models.dart';

class TrainingSetSelected {
  int id;
  String? trainingSetName;
  List<int>? imageType;
  List<WorkoutMove>? workoutMoves;
  bool selected;

  TrainingSetSelected(
      {required this.id,
      this.trainingSetName,
      this.imageType,
      this.workoutMoves,
      this.selected = false});
}
