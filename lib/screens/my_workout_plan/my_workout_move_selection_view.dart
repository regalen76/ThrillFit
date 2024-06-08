import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:onboarding/onboarding.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/models.dart';
import 'package:thrill_fit/screens/my_workout_plan/my_workout_move_selection_view_model.dart';

class MyWorkoutMoveSelectionView extends StatelessWidget {
  const MyWorkoutMoveSelectionView({required this.movesFromSets, super.key});

  final List<WorkoutMove> movesFromSets;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () =>
            MyWorkoutMoveSelectionViewModel(movesFromSets: movesFromSets),
        onViewModelReady: (vm) => vm.initialize(),
        builder: (context, vm, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Add Workout Plan'),
              backgroundColor: Colors.black,
              automaticallyImplyLeading: false,
              actions: [],
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
                                                  vm.workoutMoves[i].moveName ??
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
                                                                          .moveName ??
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
                                                              vm.deleteMoves(i);
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
                                    "${vm.totalSetSelected} of ${vm.workoutMoves.length} move(s) selected",
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
                                      onPressed: () {},
                                      style: TextButton.styleFrom(
                                        fixedSize: const Size.fromRadius(10),
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
