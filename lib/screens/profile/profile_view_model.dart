import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/services/auth.dart';

class ProfileViewModel extends BaseViewModel {
  User? user = Auth().currentUser;
  String? profilePictureUrl;

  User? get getUser => user;
  String? get getProfilePictureUrl => profilePictureUrl;

  void initState() {
    fetchProfilePictureUrl();
  }

  Future<void> fetchProfilePictureUrl() async {
    var storageRef =
        FirebaseStorage.instance.ref().child('profile-image/${user!.uid}.png');
    profilePictureUrl = await storageRef.getDownloadURL();
    notifyListeners();
  }

  void signOut() async {
    await Auth().signOut();
  }
}
