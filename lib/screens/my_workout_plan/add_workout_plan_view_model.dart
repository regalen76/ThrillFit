import 'package:stacked/stacked.dart';

class AddWorkoutPlanViewModel extends BaseViewModel {
  late List<String> goalTypes;
  int carouselCount = 0;

  void initialize() async {
    setBusy(true);
    goalTypes = [
      'Back',
      'Shoulder',
      'Abs',
      'Legs',
      'Full Body',
      'Chest',
      'Arm',
      'Cardio'
    ];
    carouselTypePage();
    setBusy(false);
    notifyListeners();
  }

  void carouselTypePage() {
    var itemCount = goalTypes.length / 3;
    carouselCount = itemCount.ceil();
  }
}
