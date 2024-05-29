import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thrill_fit/models/followers_model.dart';
import 'package:thrill_fit/models/user_model.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

class UserRepo {
  final String uid;
  Logger logger = Logger();

  UserRepo({required this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user_info');

  final CollectionReference followersCollection =
      FirebaseFirestore.instance.collection('followers');

  Stream<UserModel> get userData {
    Stream<UserModel> streamData;

    try {
      streamData = userCollection.doc(uid).snapshots().map((snap) {
        if (snap.exists) {
          return UserModel(
            age: snap.get('age'),
            challengeWins: snap.get('challenge_wins'),
            concecutiveWorkout: snap.get('consecutive_workout'),
            email: snap.get('email'),
            followers: snap.get('followers'),
            gender: snap.get('gender'),
            height: snap.get('height'),
            name: snap.get('name'),
            phone: snap.get('phone'),
            weight: snap.get('weight'),
          );
        } else {
          logger.e('Kosong');
          throw Exception('Empty field on database');
        }
      });
    } catch (e) {
      logger.e(e);
      throw Exception(e);
    }

    return streamData;
  }

  Stream<List<FollowersModel>> getFollowersStream(String userId) {
    return followersCollection
        .where('follow', isEqualTo: userId)
        .snapshots()
        .map((snap) {
      return snap.docs.map((doc) {
        return FollowersModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Stream<List<FollowersModel>> getFollowedStream(String userId) {
    return followersCollection
        .where('user', isEqualTo: userId)
        .snapshots()
        .map((snap) {
      return snap.docs.map((doc) {
        return FollowersModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Stream<List<FollowersModel>> getFollowersStreamFromUser(
      String follow, String userId) {
    return followersCollection
        .where('follow', isEqualTo: follow)
        .where('user', isEqualTo: userId)
        .snapshots()
        .map((snap) {
      return snap.docs.map((doc) {
        return FollowersModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<List<FollowersModel>> getFollowed(String userId) async {
    try {
      QuerySnapshot snapshot =
          await followersCollection.where('user', isEqualTo: userId).get();

      List<FollowersModel> followersList = snapshot.docs.map((doc) {
        return FollowersModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return followersList;
    } catch (e) {
      return [];
    }
  }

  Future createFollowersData(String follow, String user) async {
    return await followersCollection
        .doc(const Uuid().v4())
        .set(FollowersModel(follow: follow, user: user).toJson());
  }

  Future deleteFollowersData(String follow, String userId) async {
    QuerySnapshot querySnapshot = await followersCollection
        .where('follow', isEqualTo: follow)
        .where('user', isEqualTo: userId)
        .get();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      await followersCollection.doc(doc.id).delete();
    }
  }

  Future<UserModel?> getUserDataOnce() async {
    try {
      return await userCollection.doc(uid).get().then(
        (DocumentSnapshot doc) {
          if (doc.exists) {
            return UserModel.fromJson(doc.data() as Map<String, dynamic>);
          } else {
            return null;
          }
        },
        onError: (e) {
          logger.e("Error getting user data: $e");
          throw Exception('Error getting user data: $e');
        },
      );
    } catch (e) {
      throw Exception('Error getting user data: $e');
    }
  }

  Future updateUserData(String name, String phone, String gender, int height,
      int weight, int age) async {
    try {
      await userCollection.doc(uid).set({
        'name': name,
        'phone': phone,
        'gender': gender,
        'height': height,
        'weight': weight,
        'age': age
      }, SetOptions(merge: true));
    } catch (e) {
      throw Exception('Error update user data: $e');
    }
  }

  Future createUserData(UserModel userModel) async {
    try {
      await userCollection.doc(uid).set(userModel.toJson());
    } catch (e) {
      throw Exception('Error create user data: $e');
    }
  }
}
