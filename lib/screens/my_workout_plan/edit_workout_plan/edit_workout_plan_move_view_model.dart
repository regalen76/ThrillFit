import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/models.dart';

class EditWorkoutPlanMoveViewModel extends BaseViewModel {
  final MyWorkoutPlansModel detailData;
  EditWorkoutPlanMoveViewModel({required this.detailData});

  Logger logger = Logger();

  List<WorkoutMoveSelected> _workoutMoves = [];
  List<WorkoutMoveSelected> get workoutMoves => _workoutMoves;

  int _totalMoveSelected = 0;
  int get totalMoveSelected => _totalMoveSelected;

  bool _isValidSelection = false;
  bool get isValidSelection => _isValidSelection;

  void initialize() async {
    setBusy(true);

    _workoutMoves = [];
    for (int i = 0; i < detailData.workoutMoves.length; i++) {
      _workoutMoves.add(
        WorkoutMoveSelected(
            uniqueId: detailData.workoutMoves[i].id,
            movementId: detailData.workoutMoves[i].movementId,
            movementName: detailData.workoutMoves[i].movementName,
            movementImage: detailData.workoutMoves[i].movementImage,
            selected: true),
      );
    }

    for (int i = 0; i < _workoutMoves.length; i++) {
      if (_workoutMoves[i].selected) {
        _totalMoveSelected++;
      }
    }

    setBusy(false);
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

  void changeSelectedValue(String uniqueId, value) {
    for (int i = 0; i < _workoutMoves.length; i++) {
      if (_workoutMoves[i].uniqueId == uniqueId) {
        _workoutMoves[i].selected = value;
        _workoutMoves[i].selected ? _totalMoveSelected++ : _totalMoveSelected--;
      }
    }
    notifyListeners();
  }

  bool deleteMoves(int index) {
    try {
      _totalMoveSelected = 0;

      _workoutMoves.removeAt(index);

      for (int i = 0; i < _workoutMoves.length; i++) {
        if (_workoutMoves[i].selected) {
          _totalMoveSelected++;
        }
      }
      notifyListeners();
      return true;
    } catch (e) {
      logger.e("Failed to delete move, the error: $e");
      return false;
    }
  }

  bool duplicateMoves(int index, WorkoutMoveSelected data) {
    try {
      _workoutMoves.insert(
          index,
          WorkoutMoveSelected(
              movementId: data.movementId,
              movementName: data.movementName,
              movementImage: data.movementImage));

      _workoutMoves;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  void validateInput() {
    if (_totalMoveSelected > 0) {
      _isValidSelection = true;
    } else {
      _isValidSelection = false;
    }

    notifyListeners();
  }

  List<WorkoutMoveSelected> checkSelectedMoves() {
    List<WorkoutMoveSelected> listReturn = [];
    for (int i = 0; i < _workoutMoves.length; i++) {
      if (_workoutMoves[i].selected) {
        listReturn.add(_workoutMoves[i]);
      }
    }

    return listReturn;
  }
}
