import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                    : Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 24),
                              child: Text(
                                'Total Plan: ${vm.myWorkoutPlanList.length}',
                                style: const TextStyle(shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(-5.0, 5.0),
                                    blurRadius: 3.0,
                                    color: Colors.black,
                                  ),
                                ], fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        for (int i = 0;
                                            i < vm.myWorkoutPlanList.length;
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
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(8),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      8))),
                                                  title: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 4),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  vm
                                                                      .myWorkoutPlanList[
                                                                          i]
                                                                      .title,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                              Text(
                                                                'Daily moves: ',
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
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
                                                    onTap: () {},
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                          color: Colors.black,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          8),
                                                                  bottomRight:
                                                                      Radius.circular(
                                                                          8))),
                                                      child: Icon(
                                                        MdiIcons.chevronRight,
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
                          ],
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
