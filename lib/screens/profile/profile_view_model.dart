import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/services/auth.dart';

class ProfileViewModel extends BaseViewModel {
  User? user = Auth().currentUser;
  String profilePictureUrl = '';

  User? get getUser => user;
  String get getProfilePictureUrl => profilePictureUrl;

  void initState() {
    fetchProfilePictureUrl();
  }

  Future<void> fetchProfilePictureUrl() async {
    var storageRef =
        FirebaseStorage.instance.ref().child('profile-image/${user!.uid}.png');

    setBusy(true);

    try {
      profilePictureUrl = await storageRef.getDownloadURL();
    } catch (e) {
      (e as FirebaseException).code == 'object-not-found'
          ? fetchDefaultProfilePictureUrl()
          : print('Error fetching profile picture image');
    }

    setBusy(false);
    notifyListeners();
  }

  Future<void> fetchDefaultProfilePictureUrl() async {
    var storageRef = FirebaseStorage.instance.ref().child('default-avatar.png');

    try {
      profilePictureUrl = await storageRef.getDownloadURL();
    } catch (e) {
      print('error fetching default avatar');
    }
    notifyListeners();
  }

  void signOut() async {
    await Auth().signOut();
  }
}
