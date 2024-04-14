import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/user_model.dart';
import 'package:thrill_fit/repository/user_repo.dart';
import 'package:thrill_fit/services/auth.dart';
import 'dart:io';

class ProfileViewModel extends BaseViewModel {
  Logger logger = Logger();

  User? user = Auth().currentUser;
  String profilePictureUrl = '';
  bool isEdit = false;
  bool onTapDown = false;
  Stream<UserModel> userStream = Auth().currentUser?.uid != null
      ? UserRepo(uid: Auth().currentUser!.uid).userData
      : throw Exception("Current user is null");

  User? get getUser => user;
  String get getProfilePictureUrl => profilePictureUrl;
  bool get getIsEdit => isEdit;
  bool get getOnTapDown => onTapDown;
  Stream<UserModel> get getUserStream => userStream;

  void initState() {
    fetchProfilePictureUrl();
  }

  Future<void> fetchProfileData() async {}

  Future<void> fetchProfilePictureUrl() async {
    var storageRef =
        FirebaseStorage.instance.ref().child('profile-image/${user!.uid}.png');

    setBusy(true);

    try {
      profilePictureUrl = await storageRef.getDownloadURL();
    } catch (e) {
      (e as FirebaseException).code == 'object-not-found'
          ? await fetchDefaultProfilePictureUrl()
          : logger.e("Failed to fetch profile picture, the error: $e");
    }

    setBusy(false);
    notifyListeners();
  }

  Future<void> fetchDefaultProfilePictureUrl() async {
    var storageRef = FirebaseStorage.instance.ref().child('default-avatar.png');

    try {
      profilePictureUrl = await storageRef.getDownloadURL();
    } catch (e) {
      logger.e("error fetching default avatar, the error: $e");
    }
    notifyListeners();
  }

  void signOut() async {
    await Auth().signOut();
  }

  toggleEdit() {
    isEdit = !isEdit;
    notifyListeners();
  }

  toggleOnTapDown() {
    onTapDown = !onTapDown;
    logger.i(onTapDown);
    notifyListeners();
  }

  changeProfilePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? img = await picker.pickImage(source: ImageSource.gallery);
    if (img == null) return;

    final theRef =
        FirebaseStorage.instance.ref().child('profile-image/${user!.uid}.png');

    bool isSuccess = false;
    UploadTask? uploadTask;
    setBusy(true);
    try {
      uploadTask = theRef.putFile(File(img.path));
      isSuccess = true;
    } catch (e) {
      logger.e('Failed to upload new profile picture, the error: $e');
      setBusy(false);
    }

    if (isSuccess) {
      uploadTask!
          .whenComplete(() async => await setUploadedProfilePicture(theRef));
    }
  }

  setUploadedProfilePicture(Reference theRef) async {
    try {
      profilePictureUrl = await theRef.getDownloadURL();
      setBusy(false);
      notifyListeners();
    } catch (e) {
      logger.e("Failed to fetch profile picture, the error: $e");
    }
  }
}
