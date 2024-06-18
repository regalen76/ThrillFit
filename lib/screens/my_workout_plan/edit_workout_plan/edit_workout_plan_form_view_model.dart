import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/models.dart';
import 'package:thrill_fit/repository/workout_plan_repo.dart';

class EditWorkoutPlanFormViewModel extends BaseViewModel {
  final List<WorkoutMoveSelected> listSavedMove;
  final MyWorkoutPlansModel formData;

  EditWorkoutPlanFormViewModel({
    required this.listSavedMove,
    required this.formData,
  });

  Logger logger = Logger();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final TextEditingController _titleController = TextEditingController();
  TextEditingController get titleController => _titleController;

  final TextEditingController _descController = TextEditingController();
  TextEditingController get descController => _descController;

  final TextEditingController _repetitionController = TextEditingController();
  TextEditingController get repetitionController => _repetitionController;

  String _selectedOption = 'Yes';
  String get selectedOption => _selectedOption;

  void initialize() async {
    setBusy(true);

    _titleController.text = formData.title;
    _descController.text = formData.description;
    _repetitionController.text = formData.repetition.toString();

    setBusy(false);
    notifyListeners();
  }

  String? checkFormRepetition(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can`t be empty';
    }
    if (int.parse(value) < 1) {
      return 'Value should be more than 0';
    }
    return null;
  }

  String? checkFormTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can`t be empty';
    }
    return null;
  }

  void handleRadioValueChange(String? value) {
    _selectedOption = value!;
    notifyListeners();
  }

  bool validateInput() {
    return _formKey.currentState!.validate();
  }

  Future<bool> editWorkoutPlan(MyWorkoutPlansModel data) async {
    setBusy(true);
    try {
      var yesValue = "Yes";
      var dataPayload = WorkoutPlanRequestModel(
          userId: data.userId,
          title: titleController.text,
          description: descController.text,
          repetition: int.parse(repetitionController.text),
          dailyRepetition:
              _selectedOption.toLowerCase() == yesValue.toLowerCase()
                  ? 0
                  : data.dailyRepetition,
          lastUpdated: DateTime.now());
      var isSuccess = await WorkoutPlanRepo()
          .editWorkoutPlanData(data.id, dataPayload, listSavedMove);

      setBusy(false);
      return isSuccess;
    } catch (e) {
      logger.e("Failed to edit workout plan, the error: $e");
      setBusy(false);
      return false;
    }
  }
}
