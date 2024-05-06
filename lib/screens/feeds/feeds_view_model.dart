import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/repository/feeds_repo.dart';
import 'package:thrill_fit/services/auth.dart';

class FeedsViewModel extends BaseViewModel {
  Logger logger = Logger();

  User? user = Auth().currentUser;
  Query<Object?> postsQuery =
      FeedsRepo(uid: Auth().currentUser!.uid).getPostsQuery;

  User? get getUser => user;
  Query<Object?> get getPostsQuery => postsQuery;
}
