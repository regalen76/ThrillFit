import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/models.dart';

class StartWorkoutViewModel extends BaseViewModel {
  final MyWorkoutPlansModel workoutData;
  StartWorkoutViewModel({required this.workoutData});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _workoutName = '-';
  String get workoutName => _workoutName;

  String _workoutModel = '';
  String get workoutModel => _workoutModel;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void initialize() async {
    setBusy(true);

    var firstMove = workoutData.workoutMoves.firstOrNull;
    _currentIndex = 0;

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

  void updateCurrentIndex(bool isIncrement) {
    if (isIncrement) {
      _currentIndex++;
    } else {
      _currentIndex--;
    }
    notifyListeners();
  }
}
