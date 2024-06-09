import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:onboarding/onboarding.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/models.dart';
import 'package:thrill_fit/screens/my_workout_plan/my_workout_move_selection_view.dart';
import 'package:thrill_fit/screens/my_workout_plan/training_set_list_view_model.dart';
import 'package:thrill_fit/screens/workout_moves/workout_move_list_view.dart';

class TrainingSetListView extends StatelessWidget {
  const TrainingSetListView(
      {required this.selectedGoal,
      required this.titleInput,
      required this.descInput,
      super.key});

  final List<GoalTypeSelected> selectedGoal;
  final String titleInput;
  final String descInput;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => TrainingSetListViewModel(),
        onViewModelReady: (vm) => vm.initialize(),
        builder: (context, vm, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Select Training Sets'),
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
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Column(
                                children: [
                                  for (int i = 0;
                                      i < vm.trainingSetsDummy.length;
                                      i++) ...[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Table(columnWidths: const {
                                        0: FlexColumnWidth(7),
                                        1: FlexColumnWidth(1),
                                      }, children: [
                                        TableRow(children: [
                                          ListTile(
                                            tileColor: Colors.lime,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(8),
                                                    bottomLeft:
                                                        Radius.circular(8))),
                                            leading: Transform.scale(
                                              scale: 1.3,
                                              child: Checkbox(
                                                value: vm.trainingSetsDummy[i]
                                                    .selected,
                                                onChanged: (value) {
                                                  vm.changeSelectedValue(
                                                      vm.trainingSetsDummy[i]
                                                          .id,
                                                      value);
                                                },
                                                visualDensity:
                                                    const VisualDensity(
                                                        horizontal: -4),
                                                fillColor:
                                                    MaterialStateProperty.all(
                                                        Colors.black),
                                                side: const BorderSide(
                                                    color: Colors.black),
                                                checkColor: Colors.white,
                                              ),
                                            ),
                                            title: Row(
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 4),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            vm
                                                                    .trainingSetsDummy[
                                                                        i]
                                                                    .trainingSetName ??
                                                                '-',
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        Text(
                                                          'Total moves: ${vm.countTrainingSetMoves(vm.trainingSetsDummy[i])}',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const Image(
                                                    height: 50,
                                                    width: 50,
                                                    image: AssetImage(
                                                        'assets/images/Abs.png'))
                                              ],
                                            ),
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment.fill,
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            WorkoutMoveListView(
                                                              trainingSetWidget:
                                                                  vm.trainingSetsDummy[
                                                                      i],
                                                            )));
                                              },
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight: Radius
                                                                .circular(8),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    8))),
                                                child: Icon(
                                                  MdiIcons
                                                      .informationVariantCircle,
                                                  size: 32,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ]),
                                    )
                                  ]
                                ],
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
                                    "${vm.totalSetSelected} of ${vm.trainingSetsDummy.length} set(s) selected",
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
                                        vm.validateInput();
                                        vm.combineSelectedWorkoutMoves();

                                        if (vm.isValidNextPage) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      MyWorkoutMoveSelectionView(
                                                        movesFromSets: vm
                                                            .movesFromSelectedSets,
                                                        titleInput: titleInput,
                                                        descInput: descInput,
                                                      )));
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext ctx) {
                                                return AlertDialog(
                                                  backgroundColor: background,
                                                  title: const Text(
                                                      'Error Validation'),
                                                  content: const Text(
                                                      'Please select at least one training set.'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child:
                                                          const Text('Close'),
                                                    ),
                                                  ],
                                                );
                                              });
                                        }
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor:
                                            Colors.blue, // Background Color
                                      ),
                                      child: const Text(
                                        'Next',
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
                      )
                    ],
                  ),
          );
        });
  }
}
