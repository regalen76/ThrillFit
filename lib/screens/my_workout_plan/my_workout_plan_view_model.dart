import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/models.dart';
import 'package:thrill_fit/repository/workout_plan_repo.dart';
import 'package:thrill_fit/services/auth.dart';

class MyWorkoutPlanViewModel extends BaseViewModel {
  User? user = Auth().currentUser;
  Logger logger = Logger();

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
    //Reset daily repetition after if day changed
    var lastUpdateData = DateTime(
        data.lastUpdated.year, data.lastUpdated.month, data.lastUpdated.day);
    var dateNow =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    if (lastUpdateData.isBefore(dateNow)) {
      var dataPayload = WorkoutPlanRequestModel(
          userId: data.userId,
          title: data.title,
          description: data.description,
          repetition: data.repetition,
          dailyRepetition: 0,
          lastUpdated: DateTime.now());
      await WorkoutPlanRepo()
          .editWorkoutPlanDailyRepetition(data.id, dataPayload);
    }

    List<WorkoutPlanMovesetsData> movesData =
        await WorkoutPlanRepo().getWorkoutPlanMovesets(data.id);

    List<MyWorkoutPlanMovesModel> moveList = [];
    for (int i = 0; i < movesData.length; i++) {
      var workoutMoveData = await WorkoutPlanRepo()
          .getTrainingSetMoveById(movesData[i].movementId);

      if (workoutMoveData != null) {
        var imageUrl = await getMovementImage(workoutMoveData.movementImage);

        moveList.add(MyWorkoutPlanMovesModel(
            id: movesData[i].id,
            movementId: movesData[i].movementId,
            movementName: workoutMoveData.movementName,
            movementImage: imageUrl,
            viewOrder: movesData[i].viewOrder));
      }
    }

    return MyWorkoutPlansModel(
      id: data.id,
      userId: data.userId,
      title: data.title,
      description: data.description,
      repetition: data.repetition,
      dailyRepetition: data.dailyRepetition,
      workoutMoves: moveList,
    );
  }

  Future<String> getMovementImage(String movementImage) async {
    var storageRef =
        FirebaseStorage.instance.ref().child('workout/$movementImage');

    try {
      return await storageRef.getDownloadURL();
    } catch (e) {
      logger.e("Failed to get movement image, the error: $e");
      return '';
    }
  }
}
