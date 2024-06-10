import 'package:async/async.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/post_comments_model.dart';
import 'package:thrill_fit/models/user_model.dart';
import 'package:thrill_fit/repository/feeds_repo.dart';
import 'package:thrill_fit/repository/user_repo.dart';
import 'package:thrill_fit/services/auth.dart';

class CommentModalViewModel extends BaseViewModel {
  Logger logger = Logger();
  final String postId;
  final Map<String, AsyncMemoizer<String>> ppMemoirzer = {};
  final Map<String, AsyncMemoizer<String>> nameMemoizer = {};

  late Stream<List<PostCommentsModel>> postCommentsStream;
  User? user = Auth().currentUser;
  TextEditingController commentField = TextEditingController();

  User? get getUser => user;
  Stream<List<PostCommentsModel>> get getPostCommentsStream =>
      postCommentsStream;
  TextEditingController get getNameField => commentField;

  CommentModalViewModel({required this.postId});

  void initState() {
    postCommentsStream = getPostCommentsStreamFunction(postId);
  }

  void disposeAll() {
    commentField.dispose();
  }

  Future<String> getUserName(String uid) async {
    if (!nameMemoizer.containsKey(uid)) {
      nameMemoizer[uid] = AsyncMemoizer<String>();
    }

    return nameMemoizer[uid]!.runOnce(() async {
      UserModel? data = await UserRepo(uid: uid).getUserDataOnce();
      if (data != null) {
        return data.name;
      } else {
        throw Exception("User not found");
      }
    });
  }

  Stream<List<PostCommentsModel>> getPostCommentsStreamFunction(String postId) {
    return FeedsRepo(uid: user!.uid).getCommentsStream(postId);
  }

  Future<String> fetchProfilePictureUrl(String uid) async {
    var storageRef =
        FirebaseStorage.instance.ref().child('profile-image/$uid.png');

    try {
      if (!ppMemoirzer.containsKey(uid)) {
        ppMemoirzer[uid] = AsyncMemoizer<String>();
      }

      return ppMemoirzer[uid]!.runOnce(() async {
        return await storageRef.getDownloadURL();
      });
    } catch (e) {
      logger.e("Failed to fetch profile picture, the error: $e");
      throw Exception("Failed get profile picture");
    }
  }

  Future addComments(String comments, String postId, String userId) async {
    await FeedsRepo(uid: user!.uid)
        .createCommentsData(comments, postId, userId);
    commentField.clear();
  }
}
