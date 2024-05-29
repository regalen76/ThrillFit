import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/user_model.dart';
import 'package:thrill_fit/repository/user_repo.dart';
import 'package:thrill_fit/screens/challenges/challenges_view.dart';
import 'package:thrill_fit/screens/feeds/feeds_view.dart';
import 'package:thrill_fit/screens/my_workout_plan/my_workout_plan_view.dart';
import 'package:thrill_fit/screens/profile/profile_create/profile_create.dart';
import 'package:thrill_fit/services/auth.dart';

class NavigatorViewModel extends BaseViewModel {
  Logger logger = Logger();

  User? user = Auth().currentUser;
  int currentTabIndex = 1;
  List<Widget> screens = const [
    FeedsView(),
    MyWorkoutPlanView(),
    ChallengesView()
  ];

  User? get getUser => user;
  int get getCurrentTabIndex => currentTabIndex;
  List<Widget> get getScreens => screens;

  void changeIndex(int index) {
    currentTabIndex = index;
    notifyListeners();
  }

  Future<void> initState(BuildContext context) async {
    setBusy(true);
    await checkProfileStatus(context);
    setBusy(false);
  }

  Future<void> checkProfileStatus(BuildContext context) async {
    UserModel? userModel = await UserRepo(uid: user!.uid).getUserDataOnce();

    if (userModel == null && context.mounted) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const ProfileCreateView()));
    }
  }
}
