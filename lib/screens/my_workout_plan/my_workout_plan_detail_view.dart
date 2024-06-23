import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:onboarding/onboarding.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/components/workout_move_detail_view.dart';
import 'package:thrill_fit/models/models.dart';
import 'package:thrill_fit/screens/feeds_create/share_workout/share_workout.dart';
import 'package:thrill_fit/screens/my_workout_plan/my_workout_plan_detail_view_model.dart';
import 'package:thrill_fit/screens/my_workout_plan/start_workout_plan/start_workout_view.dart';
import 'package:thrill_fit/shared/util.dart';

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
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext ctx) {
                                    return AlertDialog(
                                      backgroundColor: background,
                                      title: const Text('Delete Confirmation'),
                                      content: const Text(
                                          'Are you sure want to delete this workout plan?'),
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

                                            var isSuccess =
                                                await vm.deleteWorkoutPlan(
                                                    vm.workoutPlanData.id);

                                            if (isSuccess) {
                                              Util().flashMessageSuccess(
                                                  context,
                                                  "Success delete Workout Plan.");
                                              Navigator.of(context).pop();
                                            } else {
                                              Util().flashMessageError(context,
                                                  "Failed to delete Workout Plan.");
                                            }
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
                        PopupMenuItem(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext ctx) {
                                    return AlertDialog(
                                      backgroundColor: background,
                                      title: const Text('Reset Confirmation'),
                                      content: const Text(
                                          'Are you sure want to reset workout plan repetition?'),
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
                                                .resetWorkoutPlanRepetition(
                                                    vm.workoutPlanData);

                                            if (isSuccess) {
                                              Util().flashMessageSuccess(
                                                  context,
                                                  "Success reset Workout Plan repetition.");
                                              Navigator.of(context).pop();
                                            } else {
                                              Util().flashMessageError(context,
                                                  "Failed to reset Workout Plan repetition.");
                                            }
                                          },
                                          child: const Text(
                                            'Reset',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: Row(
                              children: [
                                Icon(MdiIcons.replay),
                                const Padding(
                                    padding: EdgeInsets.only(left: 4),
                                    child: Text('Reset'))
                              ],
                            )),
                        PopupMenuItem(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ShareWorkoutView(
                                              workoutId: myWorkoutPlan.id)));
                            },
                            child: Row(
                              children: [
                                Icon(MdiIcons.share),
                                const Padding(
                                    padding: EdgeInsets.only(left: 4),
                                    child: Text('Share'))
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
                                                fontSize: 20,
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
                                          child: Table(
                                            columnWidths: const {
                                              0: FlexColumnWidth(7),
                                              1: FlexColumnWidth(1),
                                            },
                                            children: [
                                              TableRow(
                                                children: [
                                                  ListTile(
                                                    tileColor: Colors.lime,
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(8),
                                                        bottomLeft:
                                                            Radius.circular(8),
                                                      ),
                                                    ),
                                                    title: Text(
                                                      vm
                                                          .workoutPlanData
                                                          .workoutMoves[i]
                                                          .movementName,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  TableCell(
                                                    verticalAlignment:
                                                        TableCellVerticalAlignment
                                                            .fill,
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    WorkoutMoveDetailView(
                                                                        workoutMoveData: vm.convertMoveDetail(vm
                                                                            .workoutPlanData
                                                                            .workoutMoves[i]))));
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Colors.black,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    8),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    8),
                                                          ),
                                                        ),
                                                        child: Icon(
                                                          MdiIcons
                                                              .informationVariantCircle,
                                                          size: 32,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
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
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 6),
                                  child: Center(
                                    child: Text(
                                      'Repetition done today: ${vm.workoutPlanData.dailyRepetition} / ${vm.workoutPlanData.repetition}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                                  title: const Text(
                                                      'Confirmation'),
                                                  content: const Text(
                                                      'Ready to start workouts?'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child:
                                                          const Text('Close'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        final player =
                                                            AudioPlayer();
                                                        await player.play(
                                                            AssetSource(
                                                                'sounds/start_workout.mp3'));

                                                        Navigator.of(context)
                                                            .pop();
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    StartWorkoutView(
                                                                      workoutPlanDetail:
                                                                          vm.workoutPlanData,
                                                                    )));
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
                              ],
                            ),
                          ),
                        ),
                      ],
                    ));
        });
  }
}
