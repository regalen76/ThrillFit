import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thrill_fit/models/tester_model.dart';
import 'package:uuid/uuid.dart';

class TesterRepo {
  final String uid;

  TesterRepo({required this.uid});

  final CollectionReference testerCollection =
      FirebaseFirestore.instance.collection('tester');

  //create tester collection with uuid as id document with field uid, randString, randInt
  Future createTesterData(String randString, int randInt) async {
    return await testerCollection.doc(const Uuid().v4()).set(
        TesterModel(uid: uid, randString: randString, randInt: randInt)
            .toJson());
  }

  //get tester based by user
  Stream<List<TesterModel>> get testers {
    return testerCollection
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((snap) {
      return snap.docs.map((doc) {
        return TesterModel(
            uid: doc.get('uid') ?? '',
            randString: doc.get('randString') ?? '',
            randInt: doc.get('randInt') ?? '');
      }).toList();
    });
  }
}
