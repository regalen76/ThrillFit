import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thrill_fit/models/models.dart';

class WorkoutPlanRepo {
  final CollectionReference goalTypesCollection =
      FirebaseFirestore.instance.collection('goal_types');

  Future<List<GoalTypeData>> getGoalType() async {
    try {
      QuerySnapshot snapshot = await goalTypesCollection.get();

      List<GoalTypeData> goalTypeList = snapshot.docs.map((doc) {
        return GoalTypeData(
          id: doc.id,
          goalTypeImage: doc.get('goal_type_image') ?? '',
          goalTypeName: doc.get('goal_type_name') ?? '',
        );
      }).toList();

      return goalTypeList;
    } catch (e) {
      return [];
    }
  }
}
