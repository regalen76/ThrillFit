import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/user_model.dart';
import 'package:thrill_fit/repository/user_repo.dart';
import 'package:thrill_fit/screens/navigator_view.dart';
import 'package:thrill_fit/services/auth.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

class ProfileCreateModel extends BaseViewModel {
  Logger logger = Logger();
  Reference firebaseStorageRef = FirebaseStorage.instance.ref();

  User? user = Auth().currentUser;
  String profilePath = '';
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
  String get getProfilePath => profilePath;
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
    await setDefaultProfilePicture();
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

  Future<void> setDefaultProfilePicture() async {
    ByteData imageData =
        await rootBundle.load('assets/images/default-avatar.png');
    Uint8List bytes = imageData.buffer.asUint8List();

    try {
      UploadTask uploadTask = firebaseStorageRef
          .child('profile-image/${user!.uid}.png')
          .putData(bytes, SettableMetadata(contentType: 'image/png'));
      await uploadTask;

      uploadTask.whenComplete(() async {
        profilePath = await firebaseStorageRef
            .child('profile-image/${user!.uid}.png')
            .getDownloadURL();
        notifyListeners();
      });
    } catch (e) {
      logger.e('Error uploading image: $e');
    }
  }

  Future changeProfilePicture() async {
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

  Future setUploadedProfilePicture(Reference theRef) async {
    try {
      profilePath = await theRef.getDownloadURL();
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

  Future saveCreateProfile(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      setBusy(true);
      List<String> nameSearch = [];
      String temp = "";
      for (int i = 0; i < nameField.text.length; i++) {
        temp = temp + nameField.text[i];
        nameSearch.add(temp.toLowerCase());
      }
      try {
        await UserRepo(uid: user!.uid).createUserData(UserModel(
            age: int.parse(ageField.text),
            challengeWins: 0,
            concecutiveWorkout: 0,
            email: user!.email!,
            followers: 0,
            gender: selectedGender!,
            height: int.parse(heightField.text),
            name: nameField.text,
            nameSearch: nameSearch,
            phone: phoneField.text,
            weight: int.parse(weightField.text)));

        if (context.mounted) {
          setBusy(false);
          notifyListeners();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const NavigatorView()));
        }
      } catch (e) {
        setBusy(false);
        notifyListeners();
        logger.e('Failed to create profile: $e');
      }
    }
  }
}
