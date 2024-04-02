import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thrill_fit/services/auth.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final User? user = Auth().currentUser;

  void signOut() async {
    await Auth().signOut();
  }

  Widget userUID() {
    return Text(user?.email ?? 'Not Signed In');
  }

  Widget signOutButton() {
    return ElevatedButton(
        onPressed: () {
          signOut();
          Navigator.pop(context);
        },
        child: const Text('Sign Out'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            userUID(),
            signOutButton(),
          ],
        ),
      ),
    );
  }
}
