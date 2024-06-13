import 'package:flutter/material.dart';
import 'package:onboarding/onboarding.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/workout_move_selected.dart';
import 'package:thrill_fit/screens/my_workout_plan/create_workout_plan_summary_view_model.dart';

class CreateWorkoutPlanSummaryView extends StatelessWidget {
  const CreateWorkoutPlanSummaryView(
      {required this.titleInput,
      required this.descInput,
      required this.repetitionInput,
      required this.savedMove,
      super.key});

  final String titleInput;
  final String descInput;
  final int repetitionInput;
  final List<WorkoutMoveSelected> savedMove;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => CreateWorkoutPlanSummaryViewModel(
            listOfWorkoutMove: savedMove,
            titleInput: titleInput,
            descInput: descInput,
            repetitionInput: repetitionInput),
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
                  : Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: SingleChildScrollView(
                              child: SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 24),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Title',
                                        style: TextStyle(
                                            color: Colors.lime,
                                            shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(-5.0, 5.0),
                                                blurRadius: 3.0,
                                                color: Colors.black,
                                              ),
                                            ],
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 2),
                                        child: Text(
                                          vm.titleInput,
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(top: 20),
                                        child: Text(
                                          'Description',
                                          style: TextStyle(
                                              color: Colors.lime,
                                              shadows: <Shadow>[
                                                Shadow(
                                                  offset: Offset(-5.0, 5.0),
                                                  blurRadius: 3.0,
                                                  color: Colors.black,
                                                ),
                                              ],
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 2),
                                        child: Text(
                                          vm.descInput,
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(top: 30),
                                          child: Text(
                                            'Workout Moves',
                                            style: TextStyle(
                                                shadows: <Shadow>[
                                                  Shadow(
                                                    offset: Offset(-5.0, 5.0),
                                                    blurRadius: 3.0,
                                                    color: Colors.black,
                                                  ),
                                                ],
                                                color: Colors.lime,
                                                fontSize: 26,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      const Divider(),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 12),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Total Moves: ${vm.listOfWorkoutMove.length}',
                                            ),
                                            Text(
                                              'Repetition: ${vm.repetitionInput}',
                                            )
                                          ],
                                        ),
                                      ),
                                      for (int i = 0;
                                          i < vm.listOfWorkoutMove.length;
                                          i++) ...[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.lime,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                            ),
                                            child: ListTile(
                                              title: Text(
                                                vm.listOfWorkoutMove[i]
                                                        .movementName ??
                                                    '-',
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: Theme.of(context).colorScheme.background,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 24, top: 12, left: 12, right: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(flex: 1, child: Container()),
                                Expanded(
                                  flex: 2,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor:
                                          Colors.red, // Background Color
                                    ),
                                    child: const Text(
                                      'Back',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Expanded(flex: 1, child: Container()),
                                Expanded(
                                  flex: 2,
                                  child: TextButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext ctx) {
                                            return AlertDialog(
                                              backgroundColor: background,
                                              title: const Text(
                                                  'Create Confirmation'),
                                              content: const Text(
                                                  'Are you sure want to create this workout plan?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('Close'),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    Navigator.of(context).pop();

                                                    var isSuccess = await vm
                                                        .submitWorkoutPlan();
                                                    var snackBarMsg = isSuccess
                                                        ? "Success create Workout Plan."
                                                        : "Failed to create Workout Plan.";

                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .hideCurrentSnackBar();
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            duration:
                                                                const Duration(
                                                                    seconds: 3),
                                                            backgroundColor:
                                                                isSuccess
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .red,
                                                            showCloseIcon: true,
                                                            content: Text(
                                                              snackBarMsg,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16),
                                                            )));

                                                    if (isSuccess) {
                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.of(context)
                                                          .pop();
                                                    }
                                                  },
                                                  child: const Text(
                                                    'Confirm',
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  ),
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor:
                                          Colors.blue, // Background Color
                                    ),
                                    child: const Text(
                                      'Create',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Expanded(flex: 1, child: Container()),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ));
        });
  }
}
