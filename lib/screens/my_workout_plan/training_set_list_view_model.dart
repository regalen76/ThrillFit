import 'package:stacked/stacked.dart';

class TrainingSetListViewModel extends BaseViewModel {
  List<String> dummyData = [];

  void initialize() async {
    setBusy(true);

    dummyData.add('Beginner 1232');
    dummyData.add('Beginner 2');
    dummyData.add('Beginner 3');
    dummyData.add('Beginner 423');

    setBusy(false);
    notifyListeners();
  }
}
