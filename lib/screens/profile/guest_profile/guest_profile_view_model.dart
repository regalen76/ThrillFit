import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/post_comments_model.dart';
import 'package:thrill_fit/models/post_likes_model.dart';
import 'package:thrill_fit/models/post_model.dart';
import 'package:thrill_fit/models/user_model.dart';
import 'package:thrill_fit/repository/feeds_repo.dart';
import 'package:thrill_fit/repository/user_repo.dart';
import 'package:thrill_fit/services/auth.dart';

class GuestProfileViewModel extends BaseViewModel {
  Logger logger = Logger();
  final String userUid;
  User? user = Auth().currentUser;

  GuestProfileViewModel({required this.userUid});

  String profilePictureUrl = '';

  String get getProfilePictureUrl => profilePictureUrl;
  User? get getUser => user;

  Future<void> initState() async {
    setBusy(true);
    await fetchProfilePictureUrlInit();
    setBusy(false);
  }

  Query<Object?> getPostsQuery() {
    return FeedsRepo(uid: userUid).getPostsQueryProfile;
  }

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

  Stream<List<PostCommentsModel>> getPostCommentsStream(String postId) {
    return FeedsRepo(uid: user!.uid).getCommentsStream(postId);
  }

  Stream<List<PostLikesModel>> getPostLikesStream(String postId) {
    return FeedsRepo(uid: user!.uid).getLikesStream(postId);
  }

  Stream<List<PostLikesModel>> getPostLikesStreamFromUser(String postId) {
    return FeedsRepo(uid: user!.uid).getLikesStreamFromUser(postId, user!.uid);
  }

  Future<void> fetchProfilePictureUrlInit() async {
    var storageRef =
        FirebaseStorage.instance.ref().child('profile-image/$userUid.png');

    try {
      profilePictureUrl = await storageRef.getDownloadURL();
    } catch (e) {
      logger.e("Failed to fetch profile picture, the error: $e");
    }

    notifyListeners();
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

  Future<String> getUserName(String uid) async {
    UserModel? data = await UserRepo(uid: uid).getUserDataOnce();
    return data!.name;
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

  Future addComments(String comments, String postId, String userId) async {
    return FeedsRepo(uid: user!.uid)
        .createCommentsData(comments, postId, userId);
  }

  Future likePost(String userId, String postId) async {
    return FeedsRepo(uid: user!.uid).createLikesData(postId, userId);
  }

  Future unlikePost(String userId, String postId) async {
    return FeedsRepo(uid: user!.uid).deleteLikesData(postId, userId);
  }
}
