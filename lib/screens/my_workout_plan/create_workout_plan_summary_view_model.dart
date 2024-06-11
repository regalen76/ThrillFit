import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/models.dart';
import 'package:thrill_fit/repository/workout_plan_repo.dart';
import 'package:thrill_fit/services/auth.dart';

class CreateWorkoutPlanSummaryViewModel extends BaseViewModel {
  final List<WorkoutMoveSelected> listOfWorkoutMove;
  final String titleInput;
  final String descInput;
  final int frequencyInput;

  CreateWorkoutPlanSummaryViewModel(
      {required this.listOfWorkoutMove,
      required this.titleInput,
      required this.descInput,
      required this.frequencyInput});

  User? user = Auth().currentUser;
  Logger logger = Logger();

  void initialize() async {
    setBusy(true);
    setBusy(false);

    notifyListeners();
  }

  Future<bool> submitWorkoutPlan() async {
    setBusy(true);
    try {
      var isSuccess = await WorkoutPlanRepo().createWorkoutPlan(
        user!.uid,
        titleInput,
        descInput,
        frequencyInput,
        listOfWorkoutMove,
      );
      setBusy(false);
      return isSuccess;
    } catch (e) {
      logger.e("Failed to get create workout plan, the error: $e");
      setBusy(false);
      return false;
    }
  }
}
