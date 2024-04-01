import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thrill_fit/services/auth.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final User? user = Auth().currentUser;

  void signOut() async {
    await Auth().signOut();
  }

  Widget userUID() {
    return Text(user?.email ?? 'Not Signed In');
  }

  Widget signOutButton() {
    return ElevatedButton(onPressed: signOut, child: const Text('Sign Out'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: Icon(MdiIcons.accountCircle, color: Colors.white, size: 48.0),
            tooltip: 'Profile',
            onPressed: () {},
          )
        ],
      )),
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
