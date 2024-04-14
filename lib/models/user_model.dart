class UserModel {
  final int age;
  final int challengeWins;
  final int concecutiveWorkout;
  final String email;
  final int followers;
  final String gender;
  final int height;
  final String name;
  final String phone;
  final int weight;

  UserModel(
      {required this.age,
      required this.challengeWins,
      required this.concecutiveWorkout,
      required this.email,
      required this.followers,
      required this.gender,
      required this.height,
      required this.name,
      required this.phone,
      required this.weight});

  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'challenge_wins': challengeWins,
      'concecutive_workout': concecutiveWorkout,
      'email': email,
      'followers': followers,
      'gender': gender,
      'height': height,
      'name': name,
      'phone': phone,
      'weight': weight
    };
  }
}
