import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/models.dart';

class WorkoutPlanCompletionViewModel extends BaseViewModel {
  final MyWorkoutPlansModel completionData;
  WorkoutPlanCompletionViewModel({required this.completionData});

  void initialize() async {
    setBusy(true);
    setBusy(false);
    notifyListeners();
  }
}
