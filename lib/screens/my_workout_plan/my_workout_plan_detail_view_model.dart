import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/models.dart';
import 'package:thrill_fit/repository/workout_plan_repo.dart';

class MyWorkoutPlanDetailViewModel extends BaseViewModel {
  final MyWorkoutPlansModel workoutPlanData;
  MyWorkoutPlanDetailViewModel({required this.workoutPlanData});

  Logger logger = Logger();

  List<MyWorkoutPlanMovesModel> _moveList = [];
  List<MyWorkoutPlanMovesModel> get moveList => _moveList;

  void initialize() async {
    setBusy(true);

    _moveList = [];
    for (int i = 0; i < workoutPlanData.workoutMoves.length; i++) {
      _moveList.add(MyWorkoutPlanMovesModel(
          id: workoutPlanData.workoutMoves[i].id,
          movementId: workoutPlanData.workoutMoves[i].movementId,
          movementName: workoutPlanData.workoutMoves[i].movementName,
          movementImage: workoutPlanData.workoutMoves[i].movementImage,
          viewOrder: workoutPlanData.workoutMoves[i].viewOrder));
    }

    _moveList.sort((a, b) => a.viewOrder.compareTo(b.viewOrder));

    setBusy(false);
    notifyListeners();
  }

  Future<bool> deleteWorkoutPlan(String id) async {
    setBusy(true);

    try {
      var isSuccess = await WorkoutPlanRepo().deleteMyWorkoutPlan(id);

      setBusy(false);
      return isSuccess;
    } catch (e) {
      logger.e("Failed to get create workout plan, the error: $e");
      setBusy(false);
      return false;
    }
  }

  WorkoutMoveSelected convertMoveDetail(MyWorkoutPlanMovesModel data) {
    return WorkoutMoveSelected(
      uniqueId: data.id,
      movementId: data.movementId,
      movementName: data.movementName,
      movementImage: data.movementImage,
    );
  }

  Future<bool> resetWorkoutPlanRepetition(MyWorkoutPlansModel data) async {
    setBusy(true);

    try {
      var dataPayload = WorkoutPlanRequestModel(
          userId: data.userId,
          title: data.title,
          description: data.description,
          repetition: data.repetition,
          dailyRepetition: 0,
          lastUpdated: DateTime.now());
      var isSuccess = await WorkoutPlanRepo()
          .resetWorkoutPlanRepetition(data.id, dataPayload);

      setBusy(false);
      return isSuccess;
    } catch (e) {
      logger.e("Failed to get create workout plan, the error: $e");
      setBusy(false);
      return false;
    }
  }
}
