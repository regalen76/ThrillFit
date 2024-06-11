import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/models.dart';

class MyWorkoutMoveSelectionViewModel extends BaseViewModel {
  List<WorkoutMoveSelected> movesFromSets;

  MyWorkoutMoveSelectionViewModel({required this.movesFromSets});

  void initialize() async {
    setBusy(true);
    setBusy(false);

    notifyListeners();
  }
}
