import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/models.dart';

class TrainingSetListViewModel extends BaseViewModel {
  List<TrainingSetSelected> _trainingSetsDummy = [];
  List<TrainingSetSelected> get trainingSetsDummy => _trainingSetsDummy;

  void initialize() async {
    setBusy(true);

    //Dummy Data
    _trainingSetsDummy = [
      TrainingSetSelected(
          id: 0,
          trainingSetName: 'Abs Beginner',
          workoutMoves: [
            WorkoutMove(moveName: '10 knee-to-elbows'),
            WorkoutMove(moveName: '10 flutter kicks'),
            WorkoutMove(moveName: '10 scissors'),
            WorkoutMove(moveName: '10 the hundreds'),
            WorkoutMove(moveName: '10 reverse crunches'),
            WorkoutMove(moveName: '10 sitting twists'),
          ]),
      TrainingSetSelected(
          id: 1,
          trainingSetName: 'Shoulder Beginner',
          workoutMoves: [
            WorkoutMove(moveName: '20 chest expansions'),
            WorkoutMove(moveName: '10 side arm raises'),
            WorkoutMove(moveName: '10 arm chops'),
            WorkoutMove(moveName: '10 arm scissors'),
          ]),
      TrainingSetSelected(
          id: 2,
          trainingSetName: 'Chest Advance',
          workoutMoves: [
            WorkoutMove(moveName: '10 burpees'),
            WorkoutMove(moveName: '10 regular pushup'),
            WorkoutMove(moveName: '10 decline pushup'),
            WorkoutMove(moveName: '10 incline pushup'),
          ])
    ];

    setBusy(false);
    notifyListeners();
  }

  void changeSelectedValue(int id) {
    for (int i = 0; i < _trainingSetsDummy.length; i++) {
      if (_trainingSetsDummy[i].id == id) {
        _trainingSetsDummy[i].selected = !_trainingSetsDummy[i].selected;
      }
    }
    notifyListeners();
  }
}
