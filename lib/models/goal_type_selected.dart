class GoalTypeSelected {
  int id;
  String? goalTypeName;
  String? goalTypeImage;
  bool selected;

  GoalTypeSelected(
      {required this.id,
      this.goalTypeName,
      this.goalTypeImage,
      this.selected = false});
}
