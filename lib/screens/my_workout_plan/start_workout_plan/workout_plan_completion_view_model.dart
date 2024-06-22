import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/models.dart';
import 'package:thrill_fit/repository/workout_plan_repo.dart';

class WorkoutPlanCompletionViewModel extends BaseViewModel {
  final MyWorkoutPlansModel completionData;
  WorkoutPlanCompletionViewModel({required this.completionData});

  Logger logger = Logger();

  void initialize() async {
    setBusy(true);
    setBusy(false);
    notifyListeners();
  }

  Future<bool> addWorkoutPlanRepetition(MyWorkoutPlansModel data) async {
    setBusy(true);

    try {
      var dataPayload = WorkoutPlanRequestModel(
          userId: data.userId,
          title: data.title,
          description: data.description,
          repetition: data.repetition,
          dailyRepetition: data.dailyRepetition + 1,
          lastUpdated: DateTime.now());
      var isSuccess = await WorkoutPlanRepo()
          .editWorkoutPlanDailyRepetition(data.id, dataPayload);

      setBusy(false);
      return isSuccess;
    } catch (e) {
      logger.e("Failed to edit workout plan repetition, the error: $e");
      setBusy(false);
      return false;
    }
  }
}
