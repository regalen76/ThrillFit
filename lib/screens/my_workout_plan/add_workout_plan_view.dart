import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:onboarding/onboarding.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/models.dart';
import 'package:thrill_fit/screens/my_workout_plan/add_workout_plan_view_model.dart';
import 'package:thrill_fit/screens/my_workout_plan/training_set_list_view.dart';

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
                title: const Text('Add Workout Plan'),
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
                : Form(
                    key: vm.formKey,
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: SingleChildScrollView(
                                child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 24),
                                child: TextFormField(
                                  controller: vm.titleController,
                                  maxLength: 50,
                                  maxLines: 3,
                                  minLines: 1,
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
                                  validator: vm.checkForm,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 24),
                                child: TextFormField(
                                  controller: vm.descController,
                                  maxLength: 150,
                                  maxLines: 3,
                                  minLines: 1,
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
                              const Padding(
                                padding: EdgeInsets.only(top: 30),
                                child: Center(
                                  child: Text(
                                    'Goal Types',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: ExpandablePageView.builder(
                                  controller: vm.pageController,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: vm.carouselCount,
                                  onPageChanged: (position) {
                                    vm.changePageIndex(position);
                                  },
                                  itemBuilder: (context, index) {
                                    var start = index * 4;
                                    var end = start + 4;
                                    return carouselPage(
                                        vm,
                                        vm.typeSelectList.sublist(
                                            start,
                                            end.clamp(
                                                0, vm.typeSelectList.length)));
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 24),
                                child: DotsIndicator(
                                  dotsCount: vm.carouselCount,
                                  position: vm.pageIndex,
                                  onTap: (position) {
                                    vm.changePageIndex(position);
                                    vm.animateToPage(position);
                                  },
                                  decorator: const DotsDecorator(
                                      size: Size(14, 14),
                                      activeSize: Size(12, 12),
                                      color: Colors.blue, // Inactive color
                                      activeColor: Colors.grey,
                                      spacing:
                                          EdgeInsets.symmetric(horizontal: 12)),
                                ),
                              )
                            ])),
                          ),
                        ),
                        Container(
                          color: Theme.of(context).colorScheme.background,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 24, top: 12, left: 12, right: 12),
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 6),
                                child: Center(
                                  child: Text(
                                    "${vm.totalTypeSelected} of ${vm.typeSelectList.length} type(s) selected",
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

                                        if (vm.isValidNextPage &&
                                            vm.isValidSelectedType) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          TrainingSetListView(
                                                            selectedGoal: vm
                                                                .allSelectedGoalType(),
                                                            titleInput: vm
                                                                .titleController
                                                                .text,
                                                            descInput: vm
                                                                .descController
                                                                .text,
                                                          )));
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext ctx) {
                                                return AlertDialog(
                                                  backgroundColor: background,
                                                  title: const Text(
                                                      'Error Validation'),
                                                  content: Text(
                                                      vm.buildErrorMessage()),
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
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        });
  }

  Widget carouselPage(
      AddWorkoutPlanViewModel vm, List<GoalTypeSelected> selectedList) {
    List<Widget> typeItems = [];

    for (int i = 0; i < selectedList.length; i++) {
      if (selectedList[i].goalTypeName != null &&
          selectedList[i].goalTypeName!.isNotEmpty) {
        typeItems.add(InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => vm.changeSelectedValue(selectedList[i].id),
          child: Container(
              height: 160,
              width: 160,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: selectedList[i].selected
                          ? Colors.blue
                          : Colors.transparent,
                      width: 6),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.lime),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CachedNetworkImage(
                      height: 110,
                      width: 110,
                      imageUrl: selectedList[i].goalTypeImage ?? ''),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 4),
                    child: Text(
                      selectedList[i].goalTypeName!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )),
        ));
      }
    }

    if (selectedList.length < 4) {
      var extraBox = 4 - selectedList.length;

      for (int i = 0; i < extraBox; i++) {
        typeItems.add(const SizedBox(
          height: 160,
          width: 160,
        ));
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Center(
        child: Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [...typeItems],
        ),
      ),
    );
  }
}
