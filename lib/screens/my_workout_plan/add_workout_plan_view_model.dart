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
}
