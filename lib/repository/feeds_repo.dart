import 'package:cloud_firestore/cloud_firestore.dart';

class FeedsRepo {
  final String uid;

  FeedsRepo({required this.uid});

  final CollectionReference postsCollection =
      FirebaseFirestore.instance.collection('posts');

  Query<Object?> get getPostsQuery {
    return postsCollection.orderBy('timestamp');
  }
}
