import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:onboarding/onboarding.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/models.dart';
import 'package:thrill_fit/screens/my_workout_plan/create_workout_plan_summary_view.dart';
import 'package:thrill_fit/screens/my_workout_plan/my_workout_move_selection_view_model.dart';

class MyWorkoutMoveSelectionView extends StatelessWidget {
  const MyWorkoutMoveSelectionView(
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
            MyWorkoutMoveSelectionViewModel(movesFromSets: movesFromSets),
        onViewModelReady: (vm) => vm.initialize(),
        builder: (context, vm, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Set Workout Moves'),
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
                      Container(
                        color: background,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Column(
                            children: [
                              Center(
                                child: SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Visibility(
                                        visible: vm.isLoading,
                                        child:
                                            const CircularProgressIndicator(),
                                      ),
                                      // Lazy load ModelViewer when vm.workoutModel is set
                                      if (vm.workoutModel.isNotEmpty)
                                        ModelViewer(
                                          key: ValueKey(vm.workoutModel),
                                          ar: false,
                                          autoPlay: true,
                                          src: vm.workoutModel,
                                          disableZoom: true,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Center(
                                  child: Text(
                                    vm.workoutName,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                                  key: ValueKey(vm.workoutMoves[i].id),
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
                                                color: Colors.lime,
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
                                                          vm.workoutMoves[i].id,
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
                                                              vm.setNameAndModel(
                                                                  vm
                                                                          .workoutMoves[
                                                                              i]
                                                                          .movementName ??
                                                                      '-',
                                                                  vm.workoutMoves[i]
                                                                          .movementImage ??
                                                                      '');
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
                                                                        'Play'))
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
                                                                      backgroundColor:
                                                                          background,
                                                                      title: const Text(
                                                                          'Delete Confirmation'),
                                                                      content:
                                                                          const Text(
                                                                              'Are you sure want to delete this move?'),
                                                                      actions: [
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child:
                                                                              const Text('Close'),
                                                                        ),
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            vm.deleteMoves(i);
                                                                            Navigator.of(context).pop();

                                                                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                                duration: Duration(seconds: 3),
                                                                                backgroundColor: Colors.green,
                                                                                showCloseIcon: true,
                                                                                content: Text(
                                                                                  'Success delete workout move.',
                                                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                                                )));
                                                                          },
                                                                          child:
                                                                              const Text(
                                                                            'Delete',
                                                                            style:
                                                                                TextStyle(color: Colors.red),
                                                                          ),
                                                                        ),
                                                                      ],
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
                                                              vm.duplicateMoves(
                                                                  i,
                                                                  vm.workoutMoves[
                                                                      i]);

                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .hideCurrentSnackBar();
                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                  const SnackBar(
                                                                      duration: Duration(
                                                                          seconds:
                                                                              3),
                                                                      backgroundColor:
                                                                          Colors
                                                                              .green,
                                                                      showCloseIcon:
                                                                          true,
                                                                      content:
                                                                          Text(
                                                                        'Success copy workout move.',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 16),
                                                                      )));
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

                                        if (vm.isValidSelection) {
                                          repetitionInputModal(context, vm);
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext ctx) {
                                                return AlertDialog(
                                                  backgroundColor: background,
                                                  title: const Text(
                                                      'Error Validation'),
                                                  content: const Text(
                                                      'Please select at least one workout move.'),
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

  Future repetitionInputModal(
      BuildContext context, MyWorkoutMoveSelectionViewModel vm) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              height: 200,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Form(
                  key: vm.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: vm.repetitionController,
                        cursorColor: Colors.white,
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
                                                  savedMove: vm.workoutMoves,
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
