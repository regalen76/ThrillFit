class WorkoutMove {
  final String id;
  final String? moveName;
  final String? movementImage;
  bool selected;

  WorkoutMove(
      {required this.id,
      this.moveName,
      this.movementImage,
      this.selected = false});
}
