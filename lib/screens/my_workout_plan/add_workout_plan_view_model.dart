import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/models.dart';
import 'package:thrill_fit/repository/workout_plan_repo.dart';

class AddWorkoutPlanViewModel extends BaseViewModel {
  Logger logger = Logger();
  List<GoalTypeData> _goalTypes = [];
  List<GoalTypeData> get goalTypes => _goalTypes;

  List<GoalTypeSelected> _typeSelectList = [];
  List<GoalTypeSelected> get typeSelectList => _typeSelectList;

  int _totalTypeSelected = 0;
  int get totalTypeSelected => _totalTypeSelected;

  int _carouselCount = 0;
  int get carouselCount => _carouselCount;

  int _pageIndex = 0;
  int get pageIndex => _pageIndex;

  final PageController _pageController = PageController();
  PageController get pageController => _pageController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  bool _isValidNextPage = false;
  bool get isValidNextPage => _isValidNextPage;

  bool _isValidSelectedType = false;
  bool get isValidSelectedType => _isValidSelectedType;

  final TextEditingController _titleController =
      TextEditingController(text: '');
  TextEditingController get titleController => _titleController;

  final TextEditingController _descController = TextEditingController(text: '');
  TextEditingController get descController => _descController;

  void initialize() async {
    setBusy(true);
    _goalTypes = await WorkoutPlanRepo().getGoalType();

    _typeSelectList = [];
    for (int i = 0; i < _goalTypes.length; i++) {
      var imageUrl = await getGoalTypeImage(_goalTypes[i].goalTypeImage);

      _typeSelectList.add(GoalTypeSelected(
        id: _goalTypes[i].id,
        goalTypeName: _goalTypes[i].goalTypeName,
        goalTypeImage: imageUrl,
      ));
    }

    carouselTypePage();
    setBusy(false);
    notifyListeners();
  }

  Future<String> getGoalTypeImage(String goalTypeImageName) async {
    var storageRef =
        FirebaseStorage.instance.ref().child('goal-types/$goalTypeImageName');

    try {
      return await storageRef.getDownloadURL();
    } catch (e) {
      logger.e("Failed to get goal type icon, the error: $e");
      return '';
    }
  }

  void carouselTypePage() {
    var itemCount = _typeSelectList.length / 4;
    _carouselCount = itemCount.ceil();
  }

  void changePageIndex(int current) {
    _pageIndex = current;
    notifyListeners();
  }

  void animateToPage(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 350), curve: Curves.easeIn);
  }

  void changeSelectedValue(String id) {
    for (int i = 0; i < _typeSelectList.length; i++) {
      if (_typeSelectList[i].id == id) {
        _typeSelectList[i].selected = !_typeSelectList[i].selected;
        _typeSelectList[i].selected
            ? _totalTypeSelected++
            : _totalTypeSelected--;
      }
    }
    notifyListeners();
  }

  String? checkForm(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can`t be empty';
    }
    return null;
  }

  void validateInput() {
    if (_formKey.currentState!.validate()) {
      _isValidNextPage = true;
    } else {
      _isValidNextPage = false;
    }

    if (_totalTypeSelected != 0) {
      _isValidSelectedType = true;
    } else {
      _isValidSelectedType = false;
    }

    notifyListeners();
  }

  String buildErrorMessage() {
    var message = '';
    int i = 0;

    if (!_isValidNextPage) {
      i++;
      message += '$i) Title must be filled.';
    }
    if (!_isValidSelectedType) {
      i++;
      if (i > 1) {
        message += '\n';
      }
      message += '$i) Please select at least one goal type.';
    }

    return message;
  }

  List<GoalTypeSelected> allSelectedGoalType() {
    List<GoalTypeSelected> listSelected = [];

    for (int i = 0; i < _typeSelectList.length; i++) {
      if (_typeSelectList[i].selected) {
        listSelected.add(_typeSelectList[i]);
      }
    }

    return listSelected;
  }
}
