// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      age: json['age'] as int,
      challengeWins: json['challenge_wins'] as int,
      concecutiveWorkout: json['consecutive_workout'] as int,
      email: json['email'] as String,
      followers: json['followers'] as int,
      gender: json['gender'] as String,
      height: json['height'] as int,
      name: json['name'] as String,
      phone: json['phone'] as String,
      weight: json['weight'] as int,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'age': instance.age,
      'challenge_wins': instance.challengeWins,
      'consecutive_workout': instance.concecutiveWorkout,
      'email': instance.email,
      'followers': instance.followers,
      'gender': instance.gender,
      'height': instance.height,
      'name': instance.name,
      'phone': instance.phone,
      'weight': instance.weight,
    };
