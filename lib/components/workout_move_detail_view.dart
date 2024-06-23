import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/components/workout_move_detail_view_model.dart';
import 'package:thrill_fit/models/models.dart';

class WorkoutMoveDetailView extends StatelessWidget {
  const WorkoutMoveDetailView({required this.workoutMoveData, super.key});

  final WorkoutMoveSelected workoutMoveData;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () =>
          WorkoutMoveDetailViewModel(workoutMoveDetail: workoutMoveData),
      onViewModelReady: (vm) => vm.initialize(),
      builder: (context, vm, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Workout Move Detail'),
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
                    ),
                  ],
                ))
              : Container(
                  child: vm.workoutMoveDetail.movementImage != null
                      ? Column(children: [
                          Expanded(
                            child: ModelViewer(
                              ar: false,
                              autoPlay: true,
                              src: vm.workoutMoveDetail.movementImage!,
                            ),
                          ),
                          Container(
                            color: Theme.of(context).colorScheme.background,
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 24, top: 12, left: 12, right: 12),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    vm.workoutMoveDetail.movementName ?? '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(-5.0, 5.0),
                                            blurRadius: 3.0,
                                            color: Colors.black,
                                          ),
                                        ],
                                        color: Color(0XFFe0fe0e),
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                          )
                        ])
                      : const Center(
                          child: Text('There some error to load the model'),
                        ),
                ),
        );
      },
    );
  }
}
