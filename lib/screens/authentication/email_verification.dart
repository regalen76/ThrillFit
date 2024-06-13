import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:thrill_fit/screens/navigator_view.dart';
import 'package:thrill_fit/services/auth.dart';
import 'package:thrill_fit/shared/util.dart';

class EmailVerifPage extends StatefulWidget {
  const EmailVerifPage({super.key});

  @override
  State<EmailVerifPage> createState() => EmailVerifPageState();
}

class EmailVerifPageState extends State<EmailVerifPage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  int resendCounter = 60;
  Timer? resendTimer;

  @override
  void initState() {
    super.initState();

    isEmailVerified = Auth().currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
          const Duration(seconds: 5), (_) => cheheckEmailVerified());
    }
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  Future<void> cheheckEmailVerified() async {
    await Auth().currentUser!.reload();

    setState(() {
      isEmailVerified = Auth().currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  Future<void> sendVerificationEmail() async {
    try {
      await Auth().currentUser?.sendEmailVerification();

      setState(() {
        canResendEmail = false;
      });
      resendCounter = 60;
      resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (resendCounter > 0) {
            resendCounter--;
          } else {
            resendTimer?.cancel();
          }
        });
      });
      await Future.delayed(Duration(seconds: resendCounter));
      setState(() {
        canResendEmail = true;
      });
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        if (e.message == null) {
          Util().flashMessageError(context, e.code);
        } else {
          Util().flashMessageInfo(context, e.message!);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const NavigatorView()
      : Scaffold(
          appBar: AppBar(
            title: const Text('Verification'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 70),
                  child: const Text(
                    'A verification email has been sent to your email, check your inbox',
                    style: TextStyle(fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                ),
                if (!canResendEmail) ...[
                  Container(
                    margin: const EdgeInsets.only(bottom: 70),
                    child: Text(
                      resendCounter.toString(),
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  )
                ],
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(70),
                        backgroundColor: Colors.blue),
                    icon: Icon(
                      MdiIcons.email,
                      size: 32,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Resent Email',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    onPressed: canResendEmail ? sendVerificationEmail : null),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                        minimumSize: const Size.fromHeight(70)),
                    icon: Icon(
                      MdiIcons.email,
                      size: 32,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    onPressed: () => Auth().signOut(context))
              ],
            ),
          ),
        );
}
