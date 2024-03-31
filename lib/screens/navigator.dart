import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:thrill_fit/screens/challenges/challenges_page.dart';
import 'package:thrill_fit/screens/feeds/feeds_page.dart';
import 'package:thrill_fit/screens/my_workout_plan/my_workout_plan_page.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({super.key});

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  int _currentTabIndex = 1;

  final List<Widget> _screens = const [
    FeedsPage(),
    MyWorkoutPlanPage(),
    ChallengesPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentTabIndex],
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: false,
          currentIndex: _currentTabIndex,
          backgroundColor: Colors.black,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.blue,
          onTap: (int index) {
            setState(() {
              _currentTabIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(MdiIcons.home), label: 'Feeds'),
            BottomNavigationBarItem(
                icon: Icon(MdiIcons.dumbbell), label: 'Workout Plans'),
            BottomNavigationBarItem(
                icon: Icon(MdiIcons.trophyAward), label: 'Challenges')
          ],
        ),
      ),
    );
  }
}
