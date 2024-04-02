import 'package:flutter/material.dart';

class MyWorkoutPlanView extends StatefulWidget {
  const MyWorkoutPlanView({super.key});

  @override
  State<MyWorkoutPlanView> createState() => _MyWorkoutPlanViewState();
}

class _MyWorkoutPlanViewState extends State<MyWorkoutPlanView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Workout Plan'),
      ),
      body: Center(
        child: Text('Ini My Workout Plan Page'),
      ),
    );
  }
}
