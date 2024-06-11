import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/models.dart';

class WorkoutMoveListViewModel extends BaseViewModel {
  TrainingSetSelected trainingSet;
  WorkoutMoveListViewModel({required this.trainingSet});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _workoutName = '-';
  String get workoutName => _workoutName;

  String _workoutModel = '';
  String get workoutModel => _workoutModel;

  void initialize() async {
    setBusy(true);

    var firstMove = trainingSet.workoutMoves?.firstOrNull;

    setNameAndModel(
        firstMove?.movementName ?? '-', firstMove?.movementImage ?? '');

    setBusy(false);
    notifyListeners();
  }

  void setNameAndModel(String name, String model) async {
    _isLoading = true;

    _workoutName = name;
    _workoutModel = model;

    notifyListeners();

    await Future.delayed(const Duration(seconds: 3));
    _isLoading = false;

    notifyListeners();
  }
}
