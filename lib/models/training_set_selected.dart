import 'package:thrill_fit/models/models.dart';

class TrainingSetSelected {
  int id;
  String? trainingSetName;
  String? imageType;
  List<WorkoutMove>? workoutMoves;
  bool needEquipment;
  bool selected;

  TrainingSetSelected(
      {required this.id,
      this.trainingSetName,
      this.imageType,
      this.workoutMoves,
      this.needEquipment = false,
      this.selected = false});
}
