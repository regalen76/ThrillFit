import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:onboarding/onboarding.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/components/workout_move_detail_view.dart';
import 'package:thrill_fit/models/models.dart';
import 'package:thrill_fit/screens/my_workout_plan/create_workout_plan/create_workout_plan_summary_view.dart';
import 'package:thrill_fit/screens/my_workout_plan/create_workout_plan/workout_move_selection_view_model.dart';
import 'package:thrill_fit/shared/util.dart';

class WorkoutMoveSelectionView extends StatelessWidget {
  const WorkoutMoveSelectionView(
      {required this.movesFromSets,
      required this.titleInput,
      required this.descInput,
      super.key});

  final List<WorkoutMoveSelected> movesFromSets;
  final String titleInput;
  final String descInput;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () =>
            WorkoutMoveSelectionViewModel(movesFromSets: movesFromSets),
        onViewModelReady: (vm) => vm.initialize(),
        builder: (context, vm, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Set Workout Moves'),
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
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: ReorderableListView(
                            onReorder: (oldIndex, newIndex) =>
                                vm.updateIndexTiles(oldIndex, newIndex),
                            children: [
                              for (int i = 0;
                                  i < vm.workoutMoves.length;
                                  i++) ...[
                                Container(
                                  key: ValueKey(vm.workoutMoves[i].uniqueId),
                                  child: Padding(
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
                                            Container(
                                              decoration: const BoxDecoration(
                                                color: Color(0XFFe0fe0e),
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8),
                                                  bottomLeft:
                                                      Radius.circular(8),
                                                ),
                                              ),
                                              child: ListTile(
                                                leading: Transform.scale(
                                                  scale: 1.3,
                                                  child: Checkbox(
                                                    value: vm.workoutMoves[i]
                                                        .selected,
                                                    onChanged: (value) {
                                                      vm.changeSelectedValue(
                                                          vm.workoutMoves[i]
                                                              .uniqueId,
                                                          value);
                                                    },
                                                    visualDensity:
                                                        const VisualDensity(
                                                            horizontal: -4),
                                                    fillColor:
                                                        MaterialStateProperty
                                                            .all(Colors.black),
                                                    side: const BorderSide(
                                                        color: Colors.black),
                                                    checkColor: Colors.white,
                                                  ),
                                                ),
                                                title: Text(
                                                  vm.workoutMoves[i]
                                                          .movementName ??
                                                      '-',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .fill,
                                              child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(8),
                                                      bottomRight:
                                                          Radius.circular(8),
                                                    ),
                                                  ),
                                                  child: PopupMenuButton(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .background,
                                                    itemBuilder: (context) {
                                                      return [
                                                        PopupMenuItem(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (BuildContext
                                                                              context) =>
                                                                          WorkoutMoveDetailView(
                                                                              workoutMoveData: vm.workoutMoves[i])));
                                                            },
                                                            child: Row(
                                                              children: [
                                                                Icon(MdiIcons
                                                                    .play),
                                                                const Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                4),
                                                                    child: Text(
                                                                        'Demonstrate'))
                                                              ],
                                                            )),
                                                        PopupMenuItem(
                                                            onTap: () {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          ctx) {
                                                                    return AlertDialog(
                                                                      insetPadding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      contentPadding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      content:
                                                                          SizedBox(
                                                                        height:
                                                                            200,
                                                                        width:
                                                                            100,
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            const SizedBox(
                                                                              height: 100,
                                                                              child: Center(
                                                                                child: Text(
                                                                                  'Delete this move?',
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
                                                                                  var isSuccess = vm.deleteMoves(i);
                                                                                  Navigator.of(context).pop();

                                                                                  if (isSuccess) {
                                                                                    Util().flashMessageSuccess(context, "Success delete workout move.");
                                                                                  } else {
                                                                                    Util().flashMessageError(context, "Failed to delete workout move.");
                                                                                  }
                                                                                },
                                                                                child: const Center(
                                                                                  child: Text(
                                                                                    'Delete',
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
                                                                                    'Cancel',
                                                                                    style: TextStyle(fontWeight: FontWeight.bold),
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
                                                            child: Row(
                                                              children: [
                                                                Icon(MdiIcons
                                                                    .trashCan),
                                                                const Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                4),
                                                                    child: Text(
                                                                        'Remove'))
                                                              ],
                                                            )),
                                                        PopupMenuItem(
                                                            onTap: () {
                                                              var isSuccess = vm
                                                                  .duplicateMoves(
                                                                      i,
                                                                      vm.workoutMoves[
                                                                          i]);

                                                              if (isSuccess) {
                                                                Util().flashMessageSuccess(
                                                                    context,
                                                                    "Success copy workout move.");
                                                              } else {
                                                                Util().flashMessageError(
                                                                    context,
                                                                    "Failed to copy workout move.");
                                                              }
                                                            },
                                                            child: Row(
                                                              children: [
                                                                Icon(MdiIcons
                                                                    .contentCopy),
                                                                const Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                4),
                                                                    child: Text(
                                                                        'Copy'))
                                                              ],
                                                            )),
                                                      ];
                                                    },
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ],
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
                                    "${vm.totalMoveSelected} of ${vm.workoutMoves.length} move(s) selected",
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
                                        vm.validateInput();

                                        if (vm.isValidSelection) {
                                          repetitionInputModal(context, vm);
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext ctx) {
                                                return AlertDialog(
                                                  insetPadding: EdgeInsets.zero,
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  title: const Center(
                                                    child: Text(
                                                        'Error Validation'),
                                                  ),
                                                  content: SizedBox(
                                                    height: 200,
                                                    width: 100,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 20,
                                                                  right: 20),
                                                          height: 100,
                                                          child: const Center(
                                                            child: Text(
                                                              'Please select at least one workout move.',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 20),
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
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: InkWell(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Center(
                                                              child: Text(
                                                                'Close',
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

  Future repetitionInputModal(
      BuildContext context, WorkoutMoveSelectionViewModel vm) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    top: 16,
                    left: 16,
                    right: 16,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 16),
                child: Form(
                  key: vm.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: vm.repetitionController,
                        cursorColor: Colors.blue,
                        maxLength: 2,
                        decoration: const InputDecoration(
                            labelText: 'Repetition',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.blue),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide:
                                  BorderSide(width: 2, color: Colors.blue),
                            )),
                        validator: vm.checkForm,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Container(),
                            ),
                            Expanded(
                              flex: 2,
                              child: TextButton(
                                onPressed: () {
                                  if (vm.validateRepetition()) {
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                CreateWorkoutPlanSummaryView(
                                                  titleInput: titleInput,
                                                  descInput: descInput,
                                                  repetitionInput: int.parse(vm
                                                      .repetitionController
                                                      .text),
                                                  savedMove:
                                                      vm.checkSelectedMoves(),
                                                )));
                                  }
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      Colors.blue, // Background Color
                                ),
                                child: const Text(
                                  'Done',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ));
        });
  }
}
