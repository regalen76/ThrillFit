import 'package:stacked/stacked.dart';

class TrainingSetListViewModel extends BaseViewModel {
  List<String> dummyData = [];

  void initialize() async {
    setBusy(true);

    dummyData.add('Beginner 1');
    dummyData.add('Beginner 2');
    dummyData.add('Beginner 3');
    dummyData.add('Beginner 4');

    setBusy(false);
    notifyListeners();
  }
}
