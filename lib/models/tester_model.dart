class TesterModel {
  final String uid;
  final String randString;
  final int randInt;

  TesterModel(
      {required this.uid, required this.randString, required this.randInt});

  Map<String, dynamic> toJson() {
    return {'uid': uid, 'randString': randString, 'randInt': randInt};
  }
}
