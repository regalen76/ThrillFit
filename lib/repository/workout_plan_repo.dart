import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thrill_fit/models/models.dart';
import 'package:uuid/uuid.dart';

class WorkoutPlanRepo {
  final CollectionReference goalTypesCollection =
      FirebaseFirestore.instance.collection('goal_types');

  final CollectionReference trainingSetCollection =
      FirebaseFirestore.instance.collection('training_sets');

  final CollectionReference trainingSetMovementsCollection =
      FirebaseFirestore.instance.collection('training_set_movements');

  final CollectionReference workoutPlanCollection =
      FirebaseFirestore.instance.collection('workout_plans');

  final CollectionReference workoutPlanMoveSetCollection =
      FirebaseFirestore.instance.collection('workout_plan_movesets');

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

  Future<bool> createWorkoutPlan(
      String userId,
      String title,
      String description,
      int repetition,
      List<WorkoutMoveSelected> movesInput) async {
    try {
      var workoutPlanId = const Uuid().v4();
      await workoutPlanCollection.doc(workoutPlanId).set(InsertWorkoutPlanModel(
              userId: userId,
              title: title,
              description: description,
              repetition: repetition,
              dailyRepetition: 0,
              lastUpdated: DateTime.now())
          .toJson());

      for (int i = 0; i < movesInput.length; i++) {
        await workoutPlanMoveSetCollection.doc(const Uuid().v4()).set(
            InsertWorkoutPlanMoveModel(
                    workoutPlanId: workoutPlanId,
                    movementName: movesInput[i].movementName ?? '',
                    movementImage: movesInput[i].movementImage ?? '',
                    viewOrder: i + 1)
                .toJson());
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<MyWorkoutPlansModel>> getMyWorkoutPlans(
    String userId,
  ) async {
    try {
      List<MyWorkoutPlansModel> myWorkoutPlans = [];

      QuerySnapshot snapshot =
          await workoutPlanCollection.where('user_id', isEqualTo: userId).get();

      myWorkoutPlans = snapshot.docs.map((doc) {
        return MyWorkoutPlansModel(
          id: doc.id,
          title: doc.get('title') ?? '',
          description: doc.get('description') ?? '',
          repetition: doc.get('repetition') ?? 0,
          dailyRepetition: doc.get('daily_repetition') ?? 0,
          workoutMoves: [],
        );
      }).toList();

      for (int i = 0; i < myWorkoutPlans.length; i++) {
        List<MyWorkoutPlanMovesModel> moveData = [];

        QuerySnapshot snapshot = await workoutPlanMoveSetCollection
            .where('workout_plan_id', isEqualTo: myWorkoutPlans[i].id)
            .get();

        moveData = snapshot.docs.map((doc) {
          return MyWorkoutPlanMovesModel(
            id: doc.id,
            movementName: doc.get('movement_name') ?? '',
            movementImage: doc.get('movement_image') ?? '',
            viewOrder: doc.get('view_order') ?? 0,
          );
        }).toList();

        for (int j = 0; j < moveData.length; j++) {
          myWorkoutPlans[i].workoutMoves.add(moveData[j]);
        }
      }

      return myWorkoutPlans;
    } catch (e) {
      return [];
    }
  }
}
