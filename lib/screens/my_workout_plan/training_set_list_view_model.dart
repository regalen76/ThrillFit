import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/models.dart';
import 'package:thrill_fit/repository/workout_plan_repo.dart';

class TrainingSetListViewModel extends BaseViewModel {
  final List<GoalTypeSelected> selectedGoal;
  TrainingSetListViewModel({required this.selectedGoal});

  Logger logger = Logger();

  List<TrainingSetSelected> _trainingSetSelected = [];
  List<TrainingSetSelected> get trainingSetSelected => _trainingSetSelected;

  List<TrainingSetData> _trainingSetData = [];
  List<TrainingSetData> get trainingSetData => _trainingSetData;

  List<WorkoutMoveData> _workoutMoveData = [];
  List<WorkoutMoveData> get workoutMoveData => _workoutMoveData;

  int _totalSetSelected = 0;
  int get totalSetSelected => _totalSetSelected;

  bool _isValidNextPage = false;
  bool get isValidNextPage => _isValidNextPage;

  List<WorkoutMoveSelected> _movesFromSelectedSets = [];
  List<WorkoutMoveSelected> get movesFromSelectedSets => _movesFromSelectedSets;

  void initialize() async {
    setBusy(true);

    _trainingSetData = await WorkoutPlanRepo().getTrainingSets(selectedGoal);

    _trainingSetSelected = [];
    for (int i = 0; i < _trainingSetData.length; i++) {
      List<WorkoutMoveSelected> workoutMovesList = [];

      _workoutMoveData =
          await WorkoutPlanRepo().getTrainingSetMoves(_trainingSetData[i].id);

      for (int j = 0; j < _workoutMoveData.length; j++) {
        var imageUrl =
            await getMovementImage(_workoutMoveData[j].movementImage);

        workoutMovesList.add(WorkoutMoveSelected(
          id: _workoutMoveData[j].id,
          movementName: _workoutMoveData[j].movementName,
          movementImage: imageUrl,
        ));
      }

      _trainingSetSelected.add(TrainingSetSelected(
        id: _trainingSetData[i].id,
        goalTypeId: _trainingSetData[i].goalTypeId,
        trainingSetName: _trainingSetData[i].trainingSetName,
        workoutMoves: workoutMovesList,
      ));
    }

    for (int i = 0; i < _trainingSetSelected.length; i++) {
      for (int j = 0; j < selectedGoal.length; j++) {
        if (_trainingSetSelected[i].goalTypeId == selectedGoal[j].id) {
          _trainingSetSelected[i].imageGoalType = selectedGoal[j].goalTypeImage;
        }
      }
    }

    setBusy(false);
    notifyListeners();
  }

  Future<String> getMovementImage(String movementImage) async {
    var storageRef =
        FirebaseStorage.instance.ref().child('workout/$movementImage');

    try {
      return await storageRef.getDownloadURL();
    } catch (e) {
      logger.e("Failed to get movement image, the error: $e");
      return '';
    }
  }

  void changeSelectedValue(String id, value) {
    for (int i = 0; i < _trainingSetSelected.length; i++) {
      if (_trainingSetSelected[i].id == id) {
        _trainingSetSelected[i].selected = value;
        _trainingSetSelected[i].selected
            ? _totalSetSelected++
            : _totalSetSelected--;
      }
    }
    notifyListeners();
  }

  int countTrainingSetMoves(TrainingSetSelected trainingSet) {
    int value = 0;

    if (trainingSet.workoutMoves != null) {
      for (int i = 0; i < trainingSet.workoutMoves!.length; i++) {
        value++;
      }
    }

    return value;
  }

  void validateInput() {
    if (_totalSetSelected > 0) {
      _isValidNextPage = true;
    } else {
      _isValidNextPage = false;
    }

    notifyListeners();
  }

  void combineSelectedWorkoutMoves() {
    _movesFromSelectedSets = [];

    for (int i = 0; i < _trainingSetSelected.length; i++) {
      if (_trainingSetSelected[i].selected &&
          _trainingSetSelected[i].workoutMoves != null) {
        for (int j = 0; j < _trainingSetSelected[i].workoutMoves!.length; j++) {
          if (_trainingSetSelected[i].workoutMoves?[j] != null) {
            _movesFromSelectedSets
                .add(_trainingSetSelected[i].workoutMoves![j]);
          }
        }
      }
    }

    notifyListeners();
  }
}
