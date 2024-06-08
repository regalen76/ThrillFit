import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/workout_move.dart';
import 'package:uuid/uuid.dart';

class MyWorkoutMoveSelectionViewModel extends BaseViewModel {
  List<WorkoutMove> movesFromSets;
  MyWorkoutMoveSelectionViewModel({required this.movesFromSets});

  List<WorkoutMove> _workoutMoves = [];
  List<WorkoutMove> get workoutMoves => _workoutMoves;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _workoutName = '-';
  String get workoutName => _workoutName;

  String _workoutModel = '';
  String get workoutModel => _workoutModel;

  int _totalSetSelected = 0;
  int get totalSetSelected => _totalSetSelected;

  void initialize() async {
    setBusy(true);

    for (int i = 0; i < movesFromSets.length; i++) {
      _workoutMoves.add(WorkoutMove(
          id: movesFromSets[i].id,
          moveName: movesFromSets[i].moveName,
          movementImage: movesFromSets[i].movementImage));
    }

    var firstMove = _workoutMoves.firstOrNull;

    setNameAndModel(firstMove?.moveName ?? '-', firstMove?.movementImage ?? '');

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

  void changeSelectedValue(String id, value) {
    for (int i = 0; i < _workoutMoves.length; i++) {
      if (_workoutMoves[i].id == id) {
        _workoutMoves[i].selected = value;
        _workoutMoves[i].selected ? _totalSetSelected++ : _totalSetSelected--;
      }
    }
    notifyListeners();
  }

  void updateIndexTiles(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = _workoutMoves.removeAt(oldIndex);
    _workoutMoves.insert(newIndex, item);
    notifyListeners();
  }

  void deleteMoves(int index) {
    _workoutMoves.removeAt(index);
    notifyListeners();
  }

  void duplicateMoves(int index, WorkoutMove data) {
    String uniqueId = const Uuid().v4();
    _workoutMoves.insert(
        index,
        WorkoutMove(
            id: uniqueId,
            moveName: data.moveName,
            movementImage: data.movementImage));

    _workoutMoves;
    notifyListeners();
  }
}
