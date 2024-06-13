import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:onboarding/onboarding.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/models.dart';
import 'package:thrill_fit/screens/my_workout_plan/add_workout_plan_view.dart';
import 'package:thrill_fit/screens/my_workout_plan/my_workout_plan_detail_view.dart';
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
              backgroundColor: background,
              surfaceTintColor: background,
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
                : Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: StreamProvider<List<WorkoutPlansData>>.value(
                      value: vm.getWorkoutPlansData(),
                      initialData: const [],
                      child: Consumer<List<WorkoutPlansData>>(
                        builder: (context, snapshot, _) {
                          return snapshot.isEmpty
                              ? const Center(
                                  child: Text(
                                      'You do not have workout plan right now'),
                                )
                              : Column(children: [
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.only(top: 24),
                                    color: background,
                                    child: Text(
                                      'Total Plan: ${snapshot.length}',
                                      style: const TextStyle(
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
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 12),
                                      child: ListView.builder(
                                          itemCount: snapshot.length,
                                          itemBuilder: (context, index) {
                                            return FutureBuilder(
                                                future:
                                                    vm.fetchWorkoutPlanMoves(
                                                        snapshot[index]),
                                                builder: (context, snapshot2) {
                                                  if (snapshot2
                                                          .connectionState ==
                                                      ConnectionState.done) {
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 12),
                                                      child: Table(
                                                          columnWidths: const {
                                                            0: FlexColumnWidth(
                                                                7),
                                                            1: FlexColumnWidth(
                                                                1),
                                                          },
                                                          children: [
                                                            TableRow(children: [
                                                              ListTile(
                                                                tileColor:
                                                                    Colors.lime,
                                                                shape: const RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(
                                                                                8),
                                                                        bottomLeft:
                                                                            Radius.circular(8))),
                                                                title: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              4),
                                                                  child:
                                                                      Container(
                                                                    constraints:
                                                                        const BoxConstraints(
                                                                      minHeight:
                                                                          80,
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                              snapshot2.data!.title,
                                                                              maxLines: 2,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
                                                                          const Divider(
                                                                            thickness:
                                                                                1,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                          Container(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                                                                            decoration:
                                                                                const BoxDecoration(
                                                                              color: background,
                                                                              borderRadius: BorderRadius.all(
                                                                                Radius.circular(6),
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Text(
                                                                              'Today\'s Repetition: ${snapshot2.data!.dailyRepetition} / ${snapshot2.data!.repetition}',
                                                                              style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              TableCell(
                                                                verticalAlignment:
                                                                    TableCellVerticalAlignment
                                                                        .fill,
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors
                                                                          .transparent,
                                                                  highlightColor:
                                                                      Colors
                                                                          .transparent,
                                                                  onTap: () {
                                                                    if (snapshot2
                                                                            .data !=
                                                                        null) {
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (BuildContext context) => MyWorkoutPlanDetailView(myWorkoutPlan: snapshot2.data!)));
                                                                    }
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration: const BoxDecoration(
                                                                        color: Colors
                                                                            .black,
                                                                        borderRadius: BorderRadius.only(
                                                                            topRight:
                                                                                Radius.circular(8),
                                                                            bottomRight: Radius.circular(8))),
                                                                    child: Icon(
                                                                      MdiIcons
                                                                          .chevronRight,
                                                                      size: 32,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ]),
                                                          ]),
                                                    );
                                                  } else {
                                                    return const Center(
                                                        child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        CircularProgressIndicator(),
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 8),
                                                            child:
                                                                Text('Loading'))
                                                      ],
                                                    ));
                                                  }
                                                });
                                          }),
                                    ),
                                  ),
                                ]);
                        },
                      ),
                    ),
                  ),
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
