import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/screens/my_workout_plan/add_workout_plan_view.dart';
import 'package:thrill_fit/screens/my_workout_plan/my_workout_plan_view_model.dart';

class MyWorkoutPlanView extends StatelessWidget {
  const MyWorkoutPlanView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => MyWorkoutPlanViewModel(),
        onViewModelReady: (vm) => vm.initialize(),
        builder: (context, vm, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('My Workout Plan'),
            ),
            body: vm.isBusy
                ? const Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text('Loading'))
                    ],
                  ))
                : vm.myWorkoutPlanList.isEmpty
                    ? const Center(
                        child: Text('You do not have workout plan right now'),
                      )
                    : Container(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const AddWorkoutPlanView()));
              },
              shape: const CircleBorder(),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              tooltip: 'Increment',
              child: Icon(MdiIcons.plus),
            ),
          );
        });
  }
}
