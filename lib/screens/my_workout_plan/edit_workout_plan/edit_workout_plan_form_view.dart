import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:onboarding/onboarding.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/components/workout_move_detail_view.dart';
import 'package:thrill_fit/models/models.dart';
import 'package:thrill_fit/screens/my_workout_plan/edit_workout_plan/edit_workout_plan_form_view_model.dart';

class EditWorkoutPlanFormView extends StatelessWidget {
  const EditWorkoutPlanFormView(
      {required this.detailData, required this.savedMove, super.key});

  final MyWorkoutPlansModel detailData;
  final List<WorkoutMoveSelected> savedMove;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => EditWorkoutPlanFormViewModel(
            listSavedMove: savedMove, formData: detailData),
        onViewModelReady: (vm) => vm.initialize(),
        builder: (context, vm, child) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Workout Plan Summary'),
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
                  : Form(
                      key: vm.formKey,
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              child: SingleChildScrollView(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
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
                                                    width: 1,
                                                    color: Colors.blue),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12.0)),
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: Colors.blue),
                                              )),
                                          validator: vm.checkFormTitle,
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
                                                    width: 1,
                                                    color: Colors.blue),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12.0)),
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: Colors.blue),
                                              )),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 24),
                                        child: TextFormField(
                                          controller: vm.repetitionController,
                                          cursorColor: Colors.white,
                                          maxLength: 2,
                                          decoration: const InputDecoration(
                                              labelText: 'Repetition',
                                              labelStyle: TextStyle(
                                                color: Colors.white,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12.0)),
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color: Colors.blue),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12.0)),
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: Colors.blue),
                                              )),
                                          validator: vm.checkFormRepetition,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                        ),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(top: 24),
                                          child: Text(
                                              'Reset Today\'s Repetition?')),
                                      Row(
                                        children: [
                                          Radio<String>(
                                            value: 'No',
                                            groupValue: vm.selectedOption,
                                            onChanged:
                                                vm.handleRadioValueChange,
                                            activeColor: Colors.blue,
                                          ),
                                          const Text('No'),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Radio<String>(
                                            value: 'Yes',
                                            groupValue: vm.selectedOption,
                                            onChanged:
                                                vm.handleRadioValueChange,
                                            activeColor: Colors.blue,
                                          ),
                                          const Text('Yes'),
                                        ],
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
                                                color: Colors.lime,
                                                fontSize: 26,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      const Divider(),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 12),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Total Moves: ${vm.listSavedMove.length}',
                                            ),
                                          ],
                                        ),
                                      ),
                                      for (int i = 0;
                                          i < vm.listSavedMove.length;
                                          i++) ...[
                                        Padding(
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
                                                  ListTile(
                                                    tileColor: Colors.lime,
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(8),
                                                        bottomLeft:
                                                            Radius.circular(8),
                                                      ),
                                                    ),
                                                    title: Text(
                                                      vm.listSavedMove[i]
                                                              .movementName ??
                                                          '-',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  TableCell(
                                                    verticalAlignment:
                                                        TableCellVerticalAlignment
                                                            .fill,
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    WorkoutMoveDetailView(
                                                                        workoutMoveData:
                                                                            vm.listSavedMove[i])));
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Colors.black,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    8),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    8),
                                                          ),
                                                        ),
                                                        child: Icon(
                                                          MdiIcons
                                                              .informationVariantCircle,
                                                          size: 32,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(flex: 1, child: Container()),
                                  Expanded(
                                    flex: 2,
                                    child: TextButton(
                                      onPressed: () {
                                        if (vm.validateInput()) {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext ctx) {
                                                return AlertDialog(
                                                  backgroundColor: background,
                                                  title: const Text(
                                                      'Edit Confirmation'),
                                                  content: const Text(
                                                      'Are you sure want to edit this workout plan?'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child:
                                                          const Text('Close'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        Navigator.of(context)
                                                            .pop();

                                                        var isSuccess = await vm
                                                            .editWorkoutPlan(
                                                                vm.formData);
                                                        var snackBarMsg = isSuccess
                                                            ? "Success create Workout Plan."
                                                            : "Failed to create Workout Plan.";

                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .hideCurrentSnackBar();
                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                            SnackBar(
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            3),
                                                                backgroundColor:
                                                                    isSuccess
                                                                        ? Colors
                                                                            .green
                                                                        : Colors
                                                                            .red,
                                                                showCloseIcon:
                                                                    true,
                                                                content: Text(
                                                                  snackBarMsg,
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16),
                                                                )));

                                                        if (isSuccess) {
                                                          Navigator.of(context)
                                                              .pop();
                                                          Navigator.of(context)
                                                              .pop();
                                                          Navigator.of(context)
                                                              .pop();
                                                        }
                                                      },
                                                      child: const Text(
                                                        'Confirm',
                                                        style: TextStyle(
                                                            color: Colors.blue),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              });
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext ctx) {
                                                return AlertDialog(
                                                  backgroundColor: background,
                                                  title: const Text(
                                                      'Error Validation'),
                                                  content: const Text(
                                                      'Make sure your input is valid'),
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
                                        'Create',
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
                      ),
                    ));
        });
  }
}
