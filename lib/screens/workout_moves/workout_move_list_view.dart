import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/screens/workout_moves/workout_move_list_view_model.dart';

class WorkoutMoveListView extends StatelessWidget {
  const WorkoutMoveListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //WorkoutMoveListViewModel
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => WorkoutMoveListViewModel(),
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
                  : const Column(
                      children: [],
                    ));
        });
  }
}
