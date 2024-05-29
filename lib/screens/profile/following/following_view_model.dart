import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/user_model.dart';
import 'package:thrill_fit/repository/user_repo.dart';
import 'package:thrill_fit/services/auth.dart';

class FollowingViewModel extends BaseViewModel {
  Logger logger = Logger();
  final String userUid;

  FollowingViewModel({required this.userUid});

  User? user = Auth().currentUser;

  User? get getUser => user;

  Future<String> getUserName(String uid) async {
    UserModel? data = await UserRepo(uid: uid).getUserDataOnce();
    return data!.name;
  }

  Future<String> fetchProfilePictureUrl(String uid) async {
    var storageRef =
        FirebaseStorage.instance.ref().child('profile-image/$uid.png');

    try {
      return await storageRef.getDownloadURL();
    } catch (e) {
      logger.e("Failed to fetch profile picture, the error: $e");
      throw Exception("Failed get profile picture");
    }
  }
}
