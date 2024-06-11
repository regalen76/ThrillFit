import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/workout_move_selected.dart';
import 'package:uuid/uuid.dart';

class MyWorkoutMoveSelectionViewModel extends BaseViewModel {
  final List<WorkoutMoveSelected> movesFromSets;
  MyWorkoutMoveSelectionViewModel({required this.movesFromSets});

  List<WorkoutMoveSelected> _workoutMoves = [];
  List<WorkoutMoveSelected> get workoutMoves => _workoutMoves;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _workoutName = '-';
  String get workoutName => _workoutName;

  String _workoutModel = '';
  String get workoutModel => _workoutModel;

  int _totalMoveSelected = 0;
  int get totalMoveSelected => _totalMoveSelected;

  bool _isValidSelection = false;
  bool get isValidSelection => _isValidSelection;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final _frequencyController = TextEditingController(text: '0');
  TextEditingController get frequencyController => _frequencyController;

  void initialize() async {
    setBusy(true);

    _workoutMoves = [];
    for (int i = 0; i < movesFromSets.length; i++) {
      _workoutMoves.add(
        WorkoutMoveSelected(
            id: movesFromSets[i].id,
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

    var firstMove = _workoutMoves.firstOrNull;

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

  void changeSelectedValue(String id, value) {
    for (int i = 0; i < _workoutMoves.length; i++) {
      if (_workoutMoves[i].id == id) {
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

  void deleteMoves(int index) {
    _workoutMoves.removeAt(index);
    notifyListeners();
  }

  void duplicateMoves(int index, WorkoutMoveSelected data) {
    String uniqueId = const Uuid().v4();
    _workoutMoves.insert(
        index,
        WorkoutMoveSelected(
            id: uniqueId,
            movementName: data.movementName,
            movementImage: data.movementImage));

    _workoutMoves;
    notifyListeners();
  }

  void validateInput() {
    if (_totalMoveSelected != 0) {
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

  bool validateFrequency() {
    if (_formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}
