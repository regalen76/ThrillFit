import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thrill_fit/models/post_comments_model.dart';
import 'package:thrill_fit/models/post_likes_model.dart';
import 'package:thrill_fit/models/post_model.dart';
import 'package:uuid/uuid.dart';

class FeedsRepo {
  final String uid;

  FeedsRepo({required this.uid});

  final CollectionReference postsCollection =
      FirebaseFirestore.instance.collection('posts');

  final CollectionReference postCommentsCollection =
      FirebaseFirestore.instance.collection('post_comments');

  final CollectionReference postLikesCollection =
      FirebaseFirestore.instance.collection('post_likes');

  Query<Object?> get getPostsQuery {
    return postsCollection.orderBy('timestamp', descending: true);
  }

  Query<Object?> getPostsQueryFollowed(List<String> followed) {
    return postsCollection
        .where('author', whereIn: followed)
        .orderBy('timestamp', descending: true);
  }

  Query<Object?> get getPostsQueryProfile {
    return postsCollection
        .where('author', isEqualTo: uid)
        .orderBy('timestamp', descending: true);
  }

  Future<List<PostCommentsModel>> getComments(String postId) async {
    try {
      QuerySnapshot snapshot = await postCommentsCollection
          .where('post_id', isEqualTo: postId)
          .get();

      List<PostCommentsModel> commentsList = snapshot.docs.map((doc) {
        return PostCommentsModel(
          comments: doc.get('comments') ?? '',
          postId: doc.get('post_id') ?? '',
          user: doc.get('user') ?? '',
        );
      }).toList();

      return commentsList;
    } catch (e) {
      return [];
    }
  }

  Stream<List<PostCommentsModel>> getCommentsStream(String postId) {
    return postCommentsCollection
        .where('post_id', isEqualTo: postId)
        .snapshots()
        .map((snap) {
      return snap.docs.map((doc) {
        return PostCommentsModel(
            user: doc.get('user') ?? '',
            postId: doc.get('post_id') ?? '',
            comments: doc.get('comments') ?? '');
      }).toList();
    });
  }

  Stream<List<PostLikesModel>> getLikesStream(String postId) {
    return postLikesCollection
        .where('post_id', isEqualTo: postId)
        .snapshots()
        .map((snap) {
      return snap.docs.map((doc) {
        return PostLikesModel(
            user: doc.get('user') ?? '', postId: doc.get('post_id') ?? '');
      }).toList();
    });
  }

  Stream<List<PostLikesModel>> getLikesStreamFromUser(
      String postId, String userId) {
    return postLikesCollection
        .where('post_id', isEqualTo: postId)
        .where('user', isEqualTo: userId)
        .snapshots()
        .map((snap) {
      return snap.docs.map((doc) {
        return PostLikesModel(
            user: doc.get('user') ?? '', postId: doc.get('post_id') ?? '');
      }).toList();
    });
  }

  Future createPostData(String body, List<String> content) async {
    return await postsCollection.doc(const Uuid().v4()).set(PostModel(
            author: uid,
            content: content,
            body: body,
            timestamp: DateTime.now(),
            workoutPlan: null)
        .toJson());
  }

  Future createPostDataWorkoutPlan(
      String body, String workoutId, List<String> content) async {
    return await postsCollection.doc(const Uuid().v4()).set(PostModel(
            author: uid,
            content: content,
            body: body,
            timestamp: DateTime.now(),
            workoutPlan: workoutId)
        .toJson());
  }

  Future createCommentsData(String comments, String postId, String user) async {
    return await postCommentsCollection.doc(const Uuid().v4()).set(
        PostCommentsModel(comments: comments, postId: postId, user: user)
            .toJson());
  }

  Future createLikesData(String postId, String user) async {
    return await postLikesCollection
        .doc(const Uuid().v4())
        .set(PostLikesModel(postId: postId, user: user).toJson());
  }

  Future deleteLikesData(String postId, String userId) async {
    QuerySnapshot querySnapshot = await postLikesCollection
        .where('post_id', isEqualTo: postId)
        .where('user', isEqualTo: userId)
        .get();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      await postLikesCollection.doc(doc.id).delete();
    }
  }

  Future<void> deletePost(String postId) async {
    await postsCollection.doc(postId).delete();
  }
}
