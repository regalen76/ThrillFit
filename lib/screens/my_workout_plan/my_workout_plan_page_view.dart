import 'package:flutter/material.dart';

class MyWorkoutPlanPage extends StatefulWidget {
  const MyWorkoutPlanPage({super.key});

  @override
  State<MyWorkoutPlanPage> createState() => _MyWorkoutPlanPageState();
}

class _MyWorkoutPlanPageState extends State<MyWorkoutPlanPage> {
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
