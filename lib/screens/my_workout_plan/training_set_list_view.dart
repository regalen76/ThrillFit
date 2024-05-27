import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/screens/my_workout_plan/training_set_list_view_model.dart';

class TrainingSetListView extends StatelessWidget {
  const TrainingSetListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => TrainingSetListViewModel(),
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Column(
                                children: [
                                  for (int i = 0; i < 10; i++) ...[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
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
                                            leading: Transform.scale(
                                              scale: 1.3,
                                              child: Checkbox(
                                                value: true,
                                                onChanged: (value) {},
                                                visualDensity:
                                                    const VisualDensity(
                                                        horizontal: -4),
                                                fillColor:
                                                    MaterialStateProperty.all(
                                                        Colors.black),
                                                checkColor: Colors.white,
                                              ),
                                            ),
                                            title: Image(
                                                height: 110,
                                                width: 110,
                                                image: AssetImage(
                                                    'assets/images/Abs.png')),
                                            subtitle: const Text(
                                              'Test',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment.fill,
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () {},
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight: Radius
                                                                .circular(8),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    8))),
                                                child: Icon(
                                                  MdiIcons
                                                      .informationVariantCircle,
                                                  size: 32,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ]),
                                    )
                                  ]
                                ],
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
                          child: Column(
                            children: [
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
