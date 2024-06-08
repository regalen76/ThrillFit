import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/models.dart';

class TrainingSetListViewModel extends BaseViewModel {
  List<TrainingSetSelected> _trainingSetsDummy = [];
  List<TrainingSetSelected> get trainingSetsDummy => _trainingSetsDummy;

  int _totalSetSelected = 0;
  int get totalSetSelected => _totalSetSelected;

  bool _isValidNextPage = false;
  bool get isValidNextPage => _isValidNextPage;

  List<WorkoutMove> _movesFromSelectedSets = [];
  List<WorkoutMove> get movesFromSelectedSets => _movesFromSelectedSets;

  void initialize() async {
    setBusy(true);

    //Dummy Data
    _trainingSetsDummy = [
      TrainingSetSelected(
          id: 'set1',
          trainingSetName: 'Abs Beginner',
          workoutMoves: [
            WorkoutMove(
                id: 'move1',
                moveName: '10 knee-to-elbows',
                movementImage:
                    'https://firebasestorage.googleapis.com/v0/b/thrillfit-e1100.appspot.com/o/workout%2Fcrunches.glb?alt=media&token=b1642808-5cf3-4594-9a46-2341807027af'),
            WorkoutMove(
                id: 'move2',
                moveName: '10 flutter kicks',
                movementImage:
                    'https://firebasestorage.googleapis.com/v0/b/thrillfit-e1100.appspot.com/o/workout%2Fcrunches.glb?alt=media&token=b1642808-5cf3-4594-9a46-2341807027af'),
            WorkoutMove(id: 'move3', moveName: '10 scissors'),
            WorkoutMove(id: 'move4', moveName: '10 the hundreds'),
            WorkoutMove(id: 'move5', moveName: '10 reverse crunches'),
            WorkoutMove(id: 'move6', moveName: '10 sitting twists'),
          ]),
      TrainingSetSelected(
          id: 'set2',
          trainingSetName: 'Shoulder Beginner',
          workoutMoves: [
            WorkoutMove(id: 'move7', moveName: '20 chest expansions'),
            WorkoutMove(id: 'move8', moveName: '10 side arm raises'),
            WorkoutMove(id: 'move9', moveName: '10 arm chops'),
            WorkoutMove(id: 'move10', moveName: '10 arm scissors'),
          ]),
      TrainingSetSelected(
          id: 'set3',
          trainingSetName: 'Chest Advance',
          workoutMoves: [
            WorkoutMove(id: 'move11', moveName: '10 burpees'),
            WorkoutMove(id: 'move12', moveName: '10 regular pushup'),
            WorkoutMove(id: 'move13', moveName: '10 decline pushup'),
            WorkoutMove(id: 'move14', moveName: '10 incline pushup'),
          ])
    ];

    setBusy(false);
    notifyListeners();
  }

  void changeSelectedValue(String id, value) {
    for (int i = 0; i < _trainingSetsDummy.length; i++) {
      if (_trainingSetsDummy[i].id == id) {
        _trainingSetsDummy[i].selected = value;
        _trainingSetsDummy[i].selected
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
    if (_totalSetSelected != 0) {
      _isValidNextPage = true;
    } else {
      _isValidNextPage = false;
    }

    notifyListeners();
  }

  void combineSelectedWorkoutMoves() {
    _movesFromSelectedSets = [];

    for (int i = 0; i < _trainingSetsDummy.length; i++) {
      if (_trainingSetsDummy[i].selected &&
          _trainingSetsDummy[i].workoutMoves != null) {
        for (int j = 0; j < _trainingSetsDummy[i].workoutMoves!.length; j++) {
          if (_trainingSetsDummy[i].workoutMoves?[j] != null) {
            _movesFromSelectedSets.add(_trainingSetsDummy[i].workoutMoves![j]);
          }
        }
      }
    }

    notifyListeners();
  }
}
