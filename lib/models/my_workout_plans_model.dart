import 'package:thrill_fit/models/models.dart';

class MyWorkoutPlansModel {
  final String id;
  final String title;
  final String description;
  final int repetition;
  final int dailyRepetition;
  final List<MyWorkoutPlanMovesModel> workoutMoves;

  MyWorkoutPlansModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.repetition,
      required this.dailyRepetition,
      required this.workoutMoves});
}
