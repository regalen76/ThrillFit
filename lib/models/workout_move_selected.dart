class WorkoutMoveSelected {
  final String id;
  final String? movementName;
  final String? movementImage;
  bool selected;

  WorkoutMoveSelected(
      {required this.id,
      this.movementName,
      this.movementImage,
      this.selected = false});
}
