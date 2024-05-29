import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/user_model.dart';
import 'package:thrill_fit/repository/user_repo.dart';
import 'package:thrill_fit/services/auth.dart';
import 'dart:io';

class ProfileDataViewModel extends BaseViewModel {
  Logger logger = Logger();

  User? user = Auth().currentUser;
  String profilePictureUrl = '';
  bool isEdit = false;
  bool onTapDown = false;
  Stream<UserModel> userStream = Auth().currentUser?.uid != null
      ? UserRepo(uid: Auth().currentUser!.uid).userData
      : throw Exception("Current user is null");

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameField = TextEditingController();
  TextEditingController phoneField = TextEditingController();
  TextEditingController heightField = TextEditingController();
  TextEditingController weightField = TextEditingController();
  TextEditingController ageField = TextEditingController();
  final List<String> genderItems = [
    'Male',
    'Female',
  ];
  String? selectedGender;

  User? get getUser => user;
  String get getProfilePictureUrl => profilePictureUrl;
  bool get getIsEdit => isEdit;
  bool get getOnTapDown => onTapDown;
  Stream<UserModel> get getUserStream => userStream;

  GlobalKey<FormState> get getFormKey => formKey;
  TextEditingController get getNameField => nameField;
  TextEditingController get getPhoneField => phoneField;
  TextEditingController get getHeightField => heightField;
  TextEditingController get getWeightField => weightField;
  TextEditingController get getAgeField => ageField;
  List<String> get getGenderItems => genderItems;
  String? get getSelectedGender => selectedGender;

  Future<void> initState() async {
    setBusy(true);
    await fetchProfilePictureUrl();
    await setFieldData();
    setBusy(false);
  }

  void disposeAll() {
    nameField.dispose();
    phoneField.dispose();
    heightField.dispose();
    weightField.dispose();
    ageField.dispose();
  }

  void changeGender(String selectedGenderValue) {
    selectedGender = selectedGenderValue;
    notifyListeners();
  }

  Future<void> setFieldData() async {
    UserModel? userTemp = await UserRepo(uid: user!.uid).getUserDataOnce();
    if (userTemp != null) {
      nameField.text = userTemp.name;
      phoneField.text = userTemp.phone;
      selectedGender = userTemp.gender;
      heightField.text = userTemp.height.toString();
      weightField.text = userTemp.weight.toString();
      ageField.text = userTemp.age.toString();
    }
  }

  Future<void> fetchProfilePictureUrl() async {
    var storageRef =
        FirebaseStorage.instance.ref().child('profile-image/${user!.uid}.png');

    try {
      profilePictureUrl = await storageRef.getDownloadURL();
    } catch (e) {
      logger.e("Failed to fetch profile picture, the error: $e");
    }

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

  Future<void> signOut() async {
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

  String? validateEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can`t be empty';
    }
    return null;
  }

  saveEditProfile() async {
    if (formKey.currentState!.validate()) {
      setBusy(true);
      await UserRepo(uid: user!.uid).updateUserData(
          nameField.text,
          phoneField.text,
          selectedGender!,
          int.parse(heightField.text),
          int.parse(weightField.text),
          int.parse(ageField.text));

      isEdit = false;
      setBusy(false);
      notifyListeners();
    }
  }
}
