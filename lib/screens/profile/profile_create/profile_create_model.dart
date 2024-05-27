import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/services/auth.dart';

class ProfileCreateModel extends BaseViewModel {
  Logger logger = Logger();

  User? user = Auth().currentUser;

  User? get getUser => user;
}
