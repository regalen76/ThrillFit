import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/screens/my_workout_plan/add_workout_plan_view_model.dart';

class AddWorkoutPlanView extends StatelessWidget {
  const AddWorkoutPlanView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => AddWorkoutPlanViewModel(),
        onViewModelReady: (vm) => vm.initialize(),
        builder: (context, vm, child) {
          return Scaffold(
            appBar: AppBar(
                title: const Text('My Workout Plan'),
                backgroundColor: Colors.black,
                automaticallyImplyLeading: false),
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
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                              child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: TextFormField(
                                cursorColor: Colors.white,
                                decoration: const InputDecoration(
                                    labelText: 'Workout Plan Title',
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.0)),
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.blue),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.0)),
                                      borderSide: BorderSide(
                                          width: 2, color: Colors.blue),
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 24),
                              child: TextFormField(
                                cursorColor: Colors.white,
                                decoration: const InputDecoration(
                                    labelText: 'Description',
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.0)),
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.blue),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.0)),
                                      borderSide: BorderSide(
                                          width: 2, color: Colors.blue),
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 24),
                              child: ExpandablePageView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: vm.carouselCount,
                                itemBuilder: (context, index) {
                                  var start = index * 3;
                                  var end = start + 3;
                                  return carouselPage(vm.goalTypes.sublist(
                                      start,
                                      end.clamp(0, vm.goalTypes.length)));
                                },
                              ),
                            ),
                          ])),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                child: Text(
                                  'Cancel',
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
                                  fixedSize: Size.fromRadius(10),
                                  backgroundColor:
                                      Colors.blue, // Background Color
                                ),
                                child: Text(
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
          );
        });
  }

  Widget carouselPage(List<String> types) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: types
              .map((types) => Text(
                    types,
                    style: TextStyle(fontSize: 20),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
