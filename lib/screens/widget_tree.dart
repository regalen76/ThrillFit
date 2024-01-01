import 'package:flutter/material.dart';
import 'package:thrill_fit/screens/authentication/email_verification.dart';
import 'package:thrill_fit/screens/startup/landing.dart';

import '../services/auth.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: Auth().authStateChanges, builder: (context, snapshot) {
      if (snapshot.hasData) {
        return const EmailVerifPage();
      } else {
        return const LandingPage();
      }
    });
  }
}
