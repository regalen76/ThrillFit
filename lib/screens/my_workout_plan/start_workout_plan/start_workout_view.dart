import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/models.dart';
import 'package:thrill_fit/screens/my_workout_plan/start_workout_plan/start_workout_view_model.dart';
import 'package:thrill_fit/screens/my_workout_plan/start_workout_plan/workout_plan_completion_view.dart';

class StartWorkoutView extends StatelessWidget {
  const StartWorkoutView({required this.workoutPlanDetail, super.key});

  final MyWorkoutPlansModel workoutPlanDetail;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () =>
            StartWorkoutViewModel(workoutData: workoutPlanDetail),
        onViewModelReady: (vm) => vm.initialize(),
        builder: (context, vm, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Execute Workout Plan'),
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
                      Expanded(
                        child: vm.workoutModel.isNotEmpty
                            ? Stack(
                                alignment: Alignment.center,
                                children: [
                                  Visibility(
                                    visible: vm.isLoading,
                                    child: const CircularProgressIndicator(),
                                  ),
                                  ModelViewer(
                                      key: ValueKey(vm.workoutModel),
                                      ar: false,
                                      autoPlay: true,
                                      src: vm.workoutModel),
                                ],
                              )
                            : const Center(
                                child:
                                    Text('There some error to load the model'),
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
                                    'Move ${vm.currentIndex + 1} / ${vm.workoutData.workoutMoves.length}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 6),
                                child: Center(
                                  child: Text(
                                    vm.workoutName,
                                    style: const TextStyle(
                                        shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(-5.0, 5.0),
                                            blurRadius: 3.0,
                                            color: Colors.black,
                                          ),
                                        ],
                                        color: Colors.white,
                                        fontSize: 26,
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
                                    flex: 3,
                                    child: TextButton(
                                      onPressed: () async {
                                        if (vm.currentIndex > 0) {
                                          final player = AudioPlayer();
                                          await player.play(AssetSource(
                                              'sounds/change_move.mp3'));

                                          vm.updateCurrentIndex(false);
                                          vm.setNameAndModel(
                                              vm
                                                  .workoutData
                                                  .workoutMoves[vm.currentIndex]
                                                  .movementName,
                                              vm
                                                  .workoutData
                                                  .workoutMoves[vm.currentIndex]
                                                  .movementImage);
                                        }
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: (vm.currentIndex > 0)
                                            ? Colors.lime
                                            : Colors.grey,
                                      ),
                                      child: Row(children: [
                                        Icon(MdiIcons.chevronLeft,
                                            color: (vm.currentIndex > 0)
                                                ? Colors.black
                                                : Colors.grey.shade700),
                                        Expanded(
                                          child: Text(
                                            'Previous',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: (vm.currentIndex > 0)
                                                    ? Colors.black
                                                    : Colors.grey.shade700),
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ),
                                  Expanded(flex: 1, child: Container()),
                                  Expanded(
                                    flex: 3,
                                    child: TextButton(
                                      onPressed: () async {
                                        if (vm.currentIndex ==
                                            vm.workoutData.workoutMoves.length -
                                                1) {
                                          final player = AudioPlayer();
                                          await player.play(AssetSource(
                                              'sounds/complete_plan.mp3'));

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      WorkoutPlanCompletionView(
                                                        workoutPlanData:
                                                            vm.workoutData,
                                                      )));
                                        }
                                        if (vm.currentIndex <
                                            vm.workoutData.workoutMoves.length -
                                                1) {
                                          final player = AudioPlayer();
                                          await player.play(AssetSource(
                                              'sounds/change_move.mp3'));

                                          vm.updateCurrentIndex(true);
                                          vm.setNameAndModel(
                                              vm
                                                  .workoutData
                                                  .workoutMoves[vm.currentIndex]
                                                  .movementName,
                                              vm
                                                  .workoutData
                                                  .workoutMoves[vm.currentIndex]
                                                  .movementImage);
                                        }
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.lime,
                                      ),
                                      child: Row(children: [
                                        Expanded(
                                          child: Text(
                                            (vm.currentIndex ==
                                                    vm.workoutData.workoutMoves
                                                            .length -
                                                        1)
                                                ? 'Done'
                                                : 'Next',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        ),
                                        Icon(
                                            (vm.currentIndex ==
                                                    vm.workoutData.workoutMoves
                                                            .length -
                                                        1)
                                                ? MdiIcons.check
                                                : MdiIcons.chevronRight,
                                            color: Colors.black),
                                      ]),
                                    ),
                                  ),
                                  Expanded(flex: 1, child: Container()),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        });
  }
}
