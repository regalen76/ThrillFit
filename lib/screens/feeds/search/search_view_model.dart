import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/user_model.dart';
import 'package:thrill_fit/repository/user_repo.dart';
import 'package:thrill_fit/services/auth.dart';

class SearchViewModel extends BaseViewModel {
  Logger logger = Logger();
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user_info');
  final Map<String, AsyncMemoizer<String>> ppMemoirzer = {};
  
  late String userName;
  User? user = Auth().currentUser;
  TextEditingController searchController = TextEditingController();
  late Query<Object?> searchQuery;

  String get getUserName => userName;
  User? get getUser => user;
  TextEditingController get getSearhController => searchController;
  Query<Object?> get getSearchQuery => searchQuery;

  Future<void> onInit() async {
    searchController.addListener(onSearchChanged);
    userName = await fetchUserName(user!.uid);
  }

  void onDispose() {
    searchController.dispose();
  }

  void onSearchChanged() {
    if (searchController.text.isNotEmpty) {
      searchQuery =  userCollection.where("name_search", arrayContains: searchController.text);
      notifyListeners();
    }
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

  Future<String> fetchUserName(String uid) async {
    UserModel? data = await UserRepo(uid: uid).getUserDataOnce();
      if (data != null) {
        return data.name;
      } else {
        throw Exception("User not found");
      }
  }
}
