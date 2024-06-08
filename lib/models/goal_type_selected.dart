class GoalTypeSelected {
  final String id;
  final String? goalTypeName;
  final String? goalTypeImage;
  bool selected;

  GoalTypeSelected(
      {required this.id,
      this.goalTypeName,
      this.goalTypeImage,
      this.selected = false});
}
