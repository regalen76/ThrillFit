import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:onboarding/onboarding.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/components/workout_move_detail_view.dart';
import 'package:thrill_fit/models/workout_move_selected.dart';
import 'package:thrill_fit/screens/my_workout_plan/create_workout_plan/create_workout_plan_summary_view_model.dart';
import 'package:thrill_fit/shared/util.dart';

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
                actions: [
                  TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext ctx) {
                            return AlertDialog(
                              insetPadding: EdgeInsets.zero,
                              contentPadding: EdgeInsets.zero,
                              content: SizedBox(
                                height: 200,
                                width: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 100,
                                      child: Center(
                                        child: Text(
                                          'Cancel this workout plan creation?',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(color: Color.fromARGB(31, 158, 158, 158), width: 1),
                                        ),
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).pop();

                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                        },
                                        child: const Center(
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(color: Color.fromARGB(31, 158, 158, 158), width: 1),
                                        ),
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Center(
                                          child: Text(
                                            'Close',
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
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
                                            color: Color(0XFFe0fe0e),
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
                                              color: Color(0XFFe0fe0e),
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
                                                color: Color(0XFFe0fe0e),
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
                                          child: Table(
                                            columnWidths: const {
                                              0: FlexColumnWidth(7),
                                              1: FlexColumnWidth(1),
                                            },
                                            children: [
                                              TableRow(
                                                children: [
                                                  ListTile(
                                                    tileColor:
                                                        const Color(0XFFe0fe0e),
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
                                                      vm.listOfWorkoutMove[i]
                                                              .movementName ??
                                                          '-',
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
                                                                        workoutMoveData:
                                                                            vm.listOfWorkoutMove[i])));
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
                                              insetPadding: EdgeInsets.zero,
                                              contentPadding: EdgeInsets.zero,
                                              content: SizedBox(
                                                height: 200,
                                                width: 100,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(
                                                      height: 100,
                                                      child: Center(
                                                        child: Text(
                                                          'Create this workout plan?',
                                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 50,
                                                      decoration:
                                                          const BoxDecoration(
                                                        border: Border(
                                                          top: BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                      31,
                                                                      158,
                                                                      158,
                                                                      158),
                                                              width: 1),
                                                        ),
                                                      ),
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: InkWell(
                                                        onTap: () async {
                                                          Navigator.of(context)
                                                              .pop();

                                                          var isSuccess = await vm
                                                              .submitWorkoutPlan();

                                                          if (isSuccess) {
                                                            Util().flashMessageSuccess(
                                                                context,
                                                                "Success create Workout Plan.");
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          } else {
                                                            Util().flashMessageError(
                                                                context,
                                                                "Failed to create Workout Plan.");
                                                          }
                                                        },
                                                        child: const Center(
                                                          child: Text(
                                                            'Create',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 50,
                                                      decoration:
                                                          const BoxDecoration(
                                                        border: Border(
                                                          top: BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                      31,
                                                                      158,
                                                                      158,
                                                                      158),
                                                              width: 1),
                                                        ),
                                                      ),
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: InkWell(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Center(
                                                          child: Text(
                                                            'Cancel',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
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
