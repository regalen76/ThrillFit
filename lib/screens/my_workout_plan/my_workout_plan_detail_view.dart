import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:onboarding/onboarding.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/models.dart';
import 'package:thrill_fit/screens/my_workout_plan/my_workout_plan_detail_view_model.dart';

class MyWorkoutPlanDetailView extends StatelessWidget {
  const MyWorkoutPlanDetailView({required this.myWorkoutPlan, super.key});

  final MyWorkoutPlansModel myWorkoutPlan;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () =>
            MyWorkoutPlanDetailViewModel(workoutPlanData: myWorkoutPlan),
        onViewModelReady: (vm) => vm.initialize(),
        builder: (context, vm, child) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('My Workout Plan Detail'),
                backgroundColor: Colors.black,
                surfaceTintColor: background,
                actions: [
                  PopupMenuButton(
                    color: Theme.of(context).colorScheme.background,
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                            onTap: () {},
                            child: Row(
                              children: [
                                Icon(MdiIcons.play),
                                const Padding(
                                    padding: EdgeInsets.only(left: 4),
                                    child: Text('Play'))
                              ],
                            )),
                        PopupMenuItem(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext ctx) {
                                    return AlertDialog(
                                      backgroundColor: background,
                                      title: const Text('Delete Confirmation'),
                                      content: const Text(
                                          'Are you sure want to delete this move?'),
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

                                            ScaffoldMessenger.of(context)
                                                .hideCurrentSnackBar();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    duration:
                                                        Duration(seconds: 3),
                                                    backgroundColor:
                                                        Colors.green,
                                                    showCloseIcon: true,
                                                    content: Text(
                                                      'Success delete workout move.',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    )));
                                          },
                                          child: const Text(
                                            'Delete',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: Row(
                              children: [
                                Icon(MdiIcons.trashCan),
                                const Padding(
                                    padding: EdgeInsets.only(left: 4),
                                    child: Text('Remove'))
                              ],
                            )),
                      ];
                    },
                  )
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
                            child: Text('Loading'))
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
                                          vm.workoutPlanData.title,
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
                                          vm.workoutPlanData.description,
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
                                              'Total Moves: ${vm.workoutPlanData.workoutMoves.length}',
                                            ),
                                            Text(
                                              'Repetition: ${vm.workoutPlanData.repetition}',
                                            )
                                          ],
                                        ),
                                      ),
                                      for (int i = 0;
                                          i <
                                              vm.workoutPlanData.workoutMoves
                                                  .length;
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
                                                vm
                                                    .workoutPlanData
                                                    .workoutMoves[i]
                                                    .movementName,
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
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext ctx) {
                                            return AlertDialog(
                                              backgroundColor: background,
                                              title: const Text('Confirmation'),
                                              content: const Text(
                                                  'Ready to start workouts?'),
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
                                                  },
                                                  child: const Text(
                                                    'Lets go',
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
                                      'Start',
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
