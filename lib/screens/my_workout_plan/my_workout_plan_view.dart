import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:onboarding/onboarding.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/models.dart';
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(top: 24),
                          color: background,
                          child: Text(
                            'Total Plan: -',
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
                          child: SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child:
                                  StreamProvider<List<WorkoutPlansData>>.value(
                                value: vm.getWorkoutPlansData(),
                                initialData: const [],
                                child: Consumer<List<WorkoutPlansData>>(
                                  builder: (context, snapshot, _) {
                                    print(snapshot.length);
                                    return snapshot.isEmpty
                                        ? const Center(
                                            child: Text(
                                                'You do not have workout plan right now'),
                                          )
                                        : ListView.builder(
                                            itemCount: snapshot.length,
                                            itemBuilder: (context, index) {
                                              return FutureBuilder(
                                                  future:
                                                      vm.fetchWorkoutPlanMoves(
                                                          snapshot[index]),
                                                  builder:
                                                      (context, snapshot2) {
                                                    if (snapshot2
                                                            .connectionState ==
                                                        ConnectionState.done) {
                                                      print(
                                                          'hai${snapshot2.data}');
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
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
                                                              TableRow(
                                                                  children: [
                                                                    ListTile(
                                                                      tileColor:
                                                                          Colors
                                                                              .lime,
                                                                      shape: const RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.only(
                                                                              topLeft: Radius.circular(8),
                                                                              bottomLeft: Radius.circular(8))),
                                                                      title:
                                                                          Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.only(right: 4),
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(snapshot2.data!.title, style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
                                                                                  Text(
                                                                                    'Total moves: ',
                                                                                    style: const TextStyle(fontSize: 14, color: Colors.black),
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
                                                                      child:
                                                                          InkWell(
                                                                        splashColor:
                                                                            Colors.transparent,
                                                                        highlightColor:
                                                                            Colors.transparent,
                                                                        onTap:
                                                                            () {},
                                                                        child:
                                                                            Container(
                                                                          decoration: const BoxDecoration(
                                                                              color: Colors.black,
                                                                              borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8))),
                                                                          child:
                                                                              Icon(
                                                                            MdiIcons.informationVariantCircle,
                                                                            size:
                                                                                32,
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
                                                              padding: EdgeInsets
                                                                  .only(top: 8),
                                                              child: Text(
                                                                  'Loading'))
                                                        ],
                                                      ));
                                                    }
                                                  });
                                            });
                                  },
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
