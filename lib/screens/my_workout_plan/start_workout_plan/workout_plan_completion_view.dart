import 'package:flutter/material.dart';
import 'package:onboarding/onboarding.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/models.dart';
import 'package:thrill_fit/screens/my_workout_plan/start_workout_plan/workout_plan_completion_view_model.dart';
import 'package:thrill_fit/shared/util.dart';

class WorkoutPlanCompletionView extends StatelessWidget {
  const WorkoutPlanCompletionView({required this.workoutPlanData, super.key});

  final MyWorkoutPlansModel workoutPlanData;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () =>
            WorkoutPlanCompletionViewModel(completionData: workoutPlanData),
        onViewModelReady: (vm) => vm.initialize(),
        builder: (context, vm, child) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Complete Workout'),
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
                                        'Quit from this workout?',
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
                                      },
                                      child: const Center(
                                        child: Text(
                                          'Quit',
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
                                      Row(children: [
                                        const Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 12),
                                            child: Text(
                                              'Congratulations, you\'ve completed the workout!',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  shadows: <Shadow>[
                                                    Shadow(
                                                      offset: Offset(-5.0, 5.0),
                                                      blurRadius: 3.0,
                                                      color: Colors.black,
                                                    ),
                                                  ],
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Image.asset(
                                            width: 100,
                                            'assets/images/motivation.png')
                                      ]),
                                      const Padding(
                                        padding: EdgeInsets.only(top: 24),
                                        child: Text(
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
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 2),
                                        child: Text(
                                          vm.completionData.title,
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
                                        child: Text(
                                          'Total Moves: ${vm.completionData.workoutMoves.length}',
                                        ),
                                      ),
                                      for (int i = 0;
                                          i <
                                              vm.completionData.workoutMoves
                                                  .length;
                                          i++) ...[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12),
                                          child: ListTile(
                                            tileColor: const Color(0XFFe0fe0e),
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                            ),
                                            title: Text(
                                              vm.completionData.workoutMoves[i]
                                                  .movementName,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
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
                                              contentPadding:
                                                  EdgeInsets.zero,
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
                                                          'Complete this workout?',
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
                                                      onTap: () async {
                                                        Navigator.of(context).pop();

                                                        var isSuccess = await vm
                                                            .addWorkoutPlanRepetition(
                                                                vm.completionData);

                                                        if (isSuccess) {
                                                          Util().flashMessageSuccess(
                                                              context,
                                                              "Workout repetition completed.");
                                                          Navigator.of(context)
                                                              .pop();
                                                          Navigator.of(context)
                                                              .pop();
                                                          Navigator.of(context)
                                                              .pop();
                                                        } else {
                                                          Util().flashMessageError(
                                                              context,
                                                              "Failed to complete workout repetition.");
                                                        }
                                                      },
                                                      child: const Center(
                                                        child: Text(
                                                          'Complete',
                                                          style: TextStyle(fontWeight: FontWeight.bold),
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
                                              )
                                            );
                                          });
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor:
                                          Colors.blue, // Background Color
                                    ),
                                    child: const Text(
                                      'Finish',
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
