import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thrill_fit/models/models.dart';

class WorkoutPlanRepo {
  final CollectionReference goalTypesCollection =
      FirebaseFirestore.instance.collection('goal_types');

  final CollectionReference trainingSetCollection =
      FirebaseFirestore.instance.collection('training_sets');

  final CollectionReference trainingSetMovementsCollection =
      FirebaseFirestore.instance.collection('training_set_movements');

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

  Future<List<TrainingSetData>> getTrainingSets(
      List<GoalTypeSelected> goalSelected) async {
    try {
      List<String> goalTypeId = [];

      for (int i = 0; i < goalSelected.length; i++) {
        goalTypeId.add(goalSelected[i].id);
      }

      QuerySnapshot snapshot = await trainingSetCollection
          .where('goal_type_id', whereIn: goalTypeId)
          .get();

      List<TrainingSetData> trainingSetList = snapshot.docs.map((doc) {
        return TrainingSetData(
          id: doc.id,
          goalTypeId: doc.get('goal_type_id') ?? '',
          trainingSetName: doc.get('training_set_name') ?? '',
        );
      }).toList();

      return trainingSetList;
    } catch (e) {
      return [];
    }
  }

  Future<List<WorkoutMoveData>> getTrainingSetMoves(String setId) async {
    try {
      QuerySnapshot snapshot = await trainingSetMovementsCollection
          .where('training_set_id', isEqualTo: setId)
          .get();

      List<WorkoutMoveData> trainingSetList = snapshot.docs.map((doc) {
        return WorkoutMoveData(
          id: doc.id,
          movementImage: doc.get('movement_image') ?? '',
          movementName: doc.get('movement_name') ?? '',
          trainingSetId: doc.get('training_set_id') ?? '',
        );
      }).toList();

      return trainingSetList;
    } catch (e) {
      return [];
    }
  }
}
