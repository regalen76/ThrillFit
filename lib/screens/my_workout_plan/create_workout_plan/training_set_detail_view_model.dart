import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/models.dart';

class TrainingSetDetailViewModel extends BaseViewModel {
  TrainingSetSelected trainingSetDetail;
  TrainingSetDetailViewModel({required this.trainingSetDetail});

  void initialize() async {
    setBusy(true);

    setBusy(false);
    notifyListeners();
  }
}
