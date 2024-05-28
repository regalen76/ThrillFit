class GoalTypeSelected {
  int id;
  String? goalTypeName;
  List<int>? goalTypeImage;
  bool selected;

  GoalTypeSelected(
      {required this.id,
      this.goalTypeName,
      this.goalTypeImage,
      this.selected = false});
}
