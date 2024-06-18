import 'package:uuid/uuid.dart';

class WorkoutMoveSelected {
  final String uniqueId;
  final String movementId;
  final String? movementName;
  final String? movementImage;
  bool selected;

  WorkoutMoveSelected(
      {String? uniqueId,
      required this.movementId,
      this.movementName,
      this.movementImage,
      this.selected = false})
      : uniqueId = uniqueId ?? const Uuid().v4();
}
