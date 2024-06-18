import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/models.dart';

class WorkoutMoveDetailViewModel extends BaseViewModel {
  WorkoutMoveSelected workoutMoveDetail;
  WorkoutMoveDetailViewModel({required this.workoutMoveDetail});

  void initialize() async {
    setBusy(true);
    setBusy(false);
    notifyListeners();
  }
}
