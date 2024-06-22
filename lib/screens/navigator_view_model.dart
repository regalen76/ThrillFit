import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/user_model.dart';
import 'package:thrill_fit/repository/user_repo.dart';
import 'package:thrill_fit/screens/feeds/feeds_view.dart';
import 'package:thrill_fit/screens/my_workout_plan/my_workout_plan_view.dart';
import 'package:thrill_fit/screens/profile/profile_create/profile_create.dart';
import 'package:thrill_fit/screens/profile/profile_view.dart';
import 'package:thrill_fit/screens/startup/internet/connection_view.dart';
import 'package:thrill_fit/services/auth.dart';

class NavigatorViewModel extends BaseViewModel {
  Logger logger = Logger();

  User? user = Auth().currentUser;
  int currentTabIndex = 1;
  List<Widget> screens = const [
    FeedsView(),
    MyWorkoutPlanView(),
    ProfileView()
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
    await checkConnection(context);
    if (context.mounted) {
      await checkProfileStatus(context);
    }
    setBusy(false);
  }

  Future<void> checkConnection(BuildContext context) async {
    final isConnected = await InternetConnectionChecker().hasConnection;

    if (!isConnected && context.mounted) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const ConnectionView()));
    }
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
