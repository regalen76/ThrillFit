import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/models.dart';

class AddWorkoutPlanViewModel extends BaseViewModel {
  List<String> _goalTypes = [];
  List<String> get goalTypes => _goalTypes;
  List<GoalTypeSelected> _selectedList = [];
  List<GoalTypeSelected> get selectedList => _selectedList;

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

  void initialize() async {
    setBusy(true);
    _goalTypes = [
      'Shoulder',
      'Chest',
      'Biceps',
      'Triceps',
      'Forearms',
      'Buttocks',
      'Upper Leg',
      'Lower Leg',
      'Abs',
      'Upper Back',
    ];

    _selectedList = [];
    for (int i = 0; i < _goalTypes.length; i++) {
      _selectedList.add(GoalTypeSelected(type: _goalTypes[i]));
    }

    carouselTypePage();
    setBusy(false);
    notifyListeners();
  }

  void carouselTypePage() {
    var itemCount = _goalTypes.length / 4;
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

  void changeSelectedValue(String type) {
    for (int i = 0; i < _selectedList.length; i++) {
      if (_selectedList[i].type == type) {
        _selectedList[i].selected = !_selectedList[i].selected;
        _selectedList[i].selected ? _totalTypeSelected++ : _totalTypeSelected--;
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
}
