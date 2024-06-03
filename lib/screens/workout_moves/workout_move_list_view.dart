import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:onboarding/onboarding.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/models.dart';
import 'package:thrill_fit/screens/workout_moves/workout_move_list_view_model.dart';

class WorkoutMoveListView extends StatelessWidget {
  const WorkoutMoveListView({
    required this.trainingSetWidget,
    super.key,
  });

  final TrainingSetSelected trainingSetWidget;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () =>
            WorkoutMoveListViewModel(trainingSet: trainingSetWidget),
        onViewModelReady: (vm) => vm.initialize(),
        builder: (context, vm, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Workout Moves'),
              backgroundColor: Colors.black,
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
                          child: Column(children: [
                            Center(
                                child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Visibility(
                                    visible: vm.isLoading,
                                    child: const CircularProgressIndicator()),
                                SizedBox(
                                    height: 250,
                                    width: 250,
                                    child: ModelViewer(
                                        key: ValueKey(vm.workoutModel),
                                        ar: false,
                                        autoPlay: true,
                                        src: vm.workoutModel)),
                              ],
                            )),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                child: Text(vm.workoutName,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                            )
                          ]),
                        ),
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: SingleChildScrollView(
                          child: Column(children: [
                            if (vm.trainingSet.workoutMoves != null) ...[
                              for (int i = 0;
                                  i < vm.trainingSet.workoutMoves!.length;
                                  i++) ...[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
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
                                        title: Text(
                                            vm.trainingSet.workoutMoves?[i]
                                                    .moveName ??
                                                '-',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      TableCell(
                                        verticalAlignment:
                                            TableCellVerticalAlignment.fill,
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () {
                                            vm.setNameAndModel(
                                                vm.trainingSet.workoutMoves?[i]
                                                        .moveName ??
                                                    '-',
                                                vm.trainingSet.workoutMoves?[i]
                                                        .movementImage ??
                                                    '');
                                          },
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                color: Colors.black,
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(8),
                                                    bottomRight:
                                                        Radius.circular(8))),
                                            child: Icon(
                                              MdiIcons.play,
                                              size: 32,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ]),
                                ),
                              ]
                            ],
                          ]),
                        ),
                      ))
                    ],
                  ),
          );
        });
  }
}
