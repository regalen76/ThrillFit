import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thrill_fit/models/user_model.dart';
import 'package:logger/logger.dart';

class UserRepo {
  final String uid;
  Logger logger = Logger();

  UserRepo({required this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user_info');

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
