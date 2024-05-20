import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thrill_fit/models/post_comments_model.dart';
import 'package:uuid/uuid.dart';

class FeedsRepo {
  final String uid;

  FeedsRepo({required this.uid});

  final CollectionReference postsCollection =
      FirebaseFirestore.instance.collection('posts');

  final CollectionReference postCommentsCollection =
      FirebaseFirestore.instance.collection('post_comments');

  Query<Object?> get getPostsQuery {
    return postsCollection.orderBy('timestamp');
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

  Stream<List<PostCommentsModel>> get getCommentsStream {
    return postCommentsCollection
        .where('uid', isEqualTo: uid)
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

  Future createCommentsData(String comments, String postId, String user) async {
    return await postCommentsCollection.doc(const Uuid().v4()).set(
        PostCommentsModel(comments: comments, postId: postId, user: user)
            .toJson());
  }
}
