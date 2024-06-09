import 'package:flutter/material.dart';
import 'package:onboarding/onboarding.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/screens/my_workout_plan/my_workout_move_selection_view_model.dart';

class CreateWorkoutPlanSummary extends StatelessWidget {
  const CreateWorkoutPlanSummary(
      {required this.titleInput,
      required this.descInput,
      required this.frequencyInput,
      super.key});

  final String titleInput;
  final String descInput;
  final int frequencyInput;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () =>
            MyWorkoutMoveSelectionViewModel(movesFromSets: []),
        onViewModelReady: (vm) => vm.initialize(),
        builder: (context, vm, child) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Workout Plan Summary'),
                backgroundColor: Colors.black,
                automaticallyImplyLeading: false,
                actions: [
                  TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext ctx) {
                            return AlertDialog(
                              backgroundColor: background,
                              title: const Text('Cancel Confirmation'),
                              content: const Text(
                                  'Are you sure you want to cancel the workout plan creation?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Close'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();

                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Confirm',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
              body: vm.isBusy
                  ? const Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text('Loading'),
                        )
                      ],
                    ))
                  : Container(
                      child: Text('$titleInput $descInput $frequencyInput'),
                    ));
        });
  }
}
