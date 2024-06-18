import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:onboarding/onboarding.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/components/workout_move_detail_view.dart';
import 'package:thrill_fit/models/models.dart';
import 'package:thrill_fit/screens/my_workout_plan/edit_workout_plan/edit_workout_plan_form_view.dart';
import 'package:thrill_fit/screens/my_workout_plan/edit_workout_plan/edit_workout_plan_move_view_model.dart';

class EditWorkoutPlanMoveView extends StatelessWidget {
  const EditWorkoutPlanMoveView({required this.myWorkoutPlanDetail, super.key});

  final MyWorkoutPlansModel myWorkoutPlanDetail;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () =>
            EditWorkoutPlanMoveViewModel(detailData: myWorkoutPlanDetail),
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
                            backgroundColor: background,
                            title: const Text('Cancel Confirmation'),
                            content: const Text(
                                'Are you sure you want to cancel editing the workout plan?'),
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
                                                                            var isSuccess =
                                                                                vm.deleteMoves(i);
                                                                            Navigator.of(context).pop();

                                                                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                duration: const Duration(seconds: 3),
                                                                                backgroundColor: isSuccess ? Colors.green : Colors.red,
                                                                                showCloseIcon: true,
                                                                                content: Text(
                                                                                  isSuccess ? 'Success delete workout move.' : 'Failed to delete workout move.',
                                                                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                                                              var isSuccess = vm
                                                                  .duplicateMoves(
                                                                      i,
                                                                      vm.workoutMoves[
                                                                          i]);

                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .hideCurrentSnackBar();
                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                  SnackBar(
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              3),
                                                                      backgroundColor: isSuccess
                                                                          ? Colors
                                                                              .green
                                                                          : Colors
                                                                              .red,
                                                                      showCloseIcon:
                                                                          true,
                                                                      content:
                                                                          Text(
                                                                        isSuccess
                                                                            ? 'Success copy workout move.'
                                                                            : 'Failed to copy workout move.',
                                                                        style: const TextStyle(
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
                                        vm.validateInput();

                                        if (vm.isValidSelection) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      EditWorkoutPlanFormView(
                                                        detailData:
                                                            vm.detailData,
                                                        savedMove: vm
                                                            .checkSelectedMoves(),
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
}
