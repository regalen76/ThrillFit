import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/repository/feeds_repo.dart';
import 'package:thrill_fit/services/auth.dart';
import 'package:thrill_fit/shared/util.dart';
import 'package:uuid/uuid.dart';

class ShareWorkoutModel extends BaseViewModel {
  final String workoutId;
  ShareWorkoutModel({required this.workoutId});

  Logger logger = Logger();
  final ImagePicker imagePicker = ImagePicker();

  User? user = Auth().currentUser;
  List<XFile> imageFileList = [];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController commentFieldController = TextEditingController();

  User? get getUser => user;
  List<XFile> get getImageFileList => imageFileList;
  GlobalKey<FormState> get getFormKey => formKey;
  TextEditingController get getCommentFieldController => commentFieldController;

  Future<void> initState() async {
    commentFieldController.addListener(onChangeTextField);
    await pickImages();
  }

  void disposeAll() {
    commentFieldController.dispose();
  }

  void onChangeTextField() {
    notifyListeners();
  }

  Future<void> pickImages() async {
    imageFileList.clear();

    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList.addAll(selectedImages);
    }
    notifyListeners();
  }

  Future<void> createPost(BuildContext context) async {
    setBusy(true);
    await uploadImagesToFirebaseStorage();
    setBusy(false);
    notifyListeners();
    if (context.mounted) {
      Util().flashMessageSuccess(context, 'Post Successfully Created');
      Navigator.pop(context);
    }
  }

  Future<void> uploadPostData(List<String> imagePaths) async {
    await FeedsRepo(uid: user!.uid).createPostDataWorkoutPlan(
        commentFieldController.text, workoutId, imagePaths);
  }

  Future<void> uploadImagesToFirebaseStorage() async {
    List<String> imagePaths = [];

    for (var imageFile in imageFileList) {
      File file = File(imageFile.path);
      try {
        String fileName =
            '${const Uuid().v4()}.${imageFile.path.split('.').last}';
        imagePaths.add(fileName);

        final storageReference =
            FirebaseStorage.instance.ref().child('feeds/$fileName');

        UploadTask uploadTask = storageReference.putFile(file);

        await uploadTask;
      } catch (e) {
        logger.e('Error uploading image: $e');
        throw Exception(e);
      }
    }

    if (imagePaths.isNotEmpty) {
      uploadPostData(imagePaths);
      notifyListeners();
    }
  }

  String? validateEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can`t be empty';
    }
    return null;
  }
}
