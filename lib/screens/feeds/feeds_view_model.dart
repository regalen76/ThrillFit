import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/post_model.dart';
import 'package:thrill_fit/models/user_model.dart';
import 'package:thrill_fit/repository/feeds_repo.dart';
import 'package:thrill_fit/repository/user_repo.dart';
import 'package:thrill_fit/services/auth.dart';

class FeedsViewModel extends BaseViewModel {
  Logger logger = Logger();

  User? user = Auth().currentUser;
  Query<Object?> postsQuery =
      FeedsRepo(uid: Auth().currentUser!.uid).getPostsQuery;

  User? get getUser => user;
  Query<Object?> get getPostsQuery => postsQuery;

  PostModel mapToPostModel(DocumentSnapshot dataSnapshot) {
    final Map<String, dynamic>? data =
        dataSnapshot.data() as Map<String, dynamic>?;

    if (data == null) {
      throw Exception("Failed to get data from firestore firebase");
    }

    if (data['author'] == null ||
        data['body'] == null ||
        data['timestamp'] == null) {
      throw Exception("Required fields missing in Firestore document");
    }

    return PostModel.fromJson(data);
  }

  Future<String> getUserName(String uid) async {
    UserModel data = await UserRepo(uid: uid).getUserDataOnce();
    return data.name;
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

  Future<String> fetchContent(String path) async {
    var storageRef = FirebaseStorage.instance.ref().child('/feeds/$path');

    try {
      return await storageRef.getDownloadURL();
    } catch (e) {
      logger.e("Failed to fetch post image, the error: $e");
      throw Exception("Failed to get post image");
    }
  }
}
