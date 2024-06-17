import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/workout_move_selected.dart';
import 'package:uuid/uuid.dart';

class WorkoutMoveSelectionViewModel extends BaseViewModel {
  final List<WorkoutMoveSelected> movesFromSets;
  WorkoutMoveSelectionViewModel({required this.movesFromSets});

  Logger logger = Logger();

  List<WorkoutMoveSelected> _workoutMoves = [];
  List<WorkoutMoveSelected> get workoutMoves => _workoutMoves;

  int _totalMoveSelected = 0;
  int get totalMoveSelected => _totalMoveSelected;

  bool _isValidSelection = false;
  bool get isValidSelection => _isValidSelection;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final _repetitionController = TextEditingController(text: '0');
  TextEditingController get repetitionController => _repetitionController;

  void initialize() async {
    setBusy(true);

    _workoutMoves = [];
    for (int i = 0; i < movesFromSets.length; i++) {
      _workoutMoves.add(
        WorkoutMoveSelected(
            movementId: movesFromSets[i].movementId,
            movementName: movesFromSets[i].movementName,
            movementImage: movesFromSets[i].movementImage,
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

  void changeSelectedValue(String uniqueId, value) {
    for (int i = 0; i < _workoutMoves.length; i++) {
      if (_workoutMoves[i].uniqueId == uniqueId) {
        _workoutMoves[i].selected = value;
        _workoutMoves[i].selected ? _totalMoveSelected++ : _totalMoveSelected--;
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

  String? checkForm(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can`t be empty';
    }
    if (int.parse(value) < 1) {
      return 'Value should be more than 0';
    }
    return null;
  }

  bool validateRepetition() {
    if (_formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
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
