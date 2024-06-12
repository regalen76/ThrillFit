import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/models.dart';
import 'package:thrill_fit/repository/workout_plan_repo.dart';
import 'package:thrill_fit/services/auth.dart';

class MyWorkoutPlanViewModel extends BaseViewModel {
  User? user = Auth().currentUser;

  void initialize() async {
    setBusy(true);
    setBusy(false);
    notifyListeners();
  }

  Stream<List<WorkoutPlansData>> getWorkoutPlansData() {
    return WorkoutPlanRepo().getWorkoutPlansData(user!.uid);
  }

  Future<MyWorkoutPlansModel> fetchWorkoutPlanMoves(
      WorkoutPlansData data) async {
    List<WorkoutPlanMovesetsData> movesData =
        await WorkoutPlanRepo().getWorkoutPlanMovesets(data.id);

    List<MyWorkoutPlanMovesModel> moveList = [];
    for (int i = 0; i < movesData.length; i++) {
      moveList.add(MyWorkoutPlanMovesModel(
          id: movesData[i].id,
          movementImage: movesData[i].movementImage,
          movementName: movesData[i].movementName,
          viewOrder: movesData[i].viewOrder));
    }

    return MyWorkoutPlansModel(
      id: data.id,
      title: data.title,
      description: data.description,
      repetition: data.repetition,
      dailyRepetition: data.dailyRepetition,
      workoutMoves: moveList,
    );
  }
}
