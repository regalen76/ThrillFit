import 'package:stacked/stacked.dart';

class WorkoutMoveListViewModel extends BaseViewModel {
  void initialize() async {
    setBusy(true);

    setBusy(false);
    notifyListeners();
  }
}
