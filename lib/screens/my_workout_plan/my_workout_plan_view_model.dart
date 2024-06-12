import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/models.dart';
import 'package:thrill_fit/repository/workout_plan_repo.dart';
import 'package:thrill_fit/services/auth.dart';

class MyWorkoutPlanViewModel extends BaseViewModel {
  User? user = Auth().currentUser;

  List<MyWorkoutPlansModel> _myWorkoutPlanList = [];
  List<MyWorkoutPlansModel> get myWorkoutPlanList => _myWorkoutPlanList;

  void initialize() async {
    setBusy(true);
    _myWorkoutPlanList = await WorkoutPlanRepo().getMyWorkoutPlans(
      user!.uid,
    );
    setBusy(false);
    notifyListeners();
  }
}
