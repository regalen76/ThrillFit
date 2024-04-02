import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:thrill_fit/screens/navigator_view.dart';
import 'package:thrill_fit/services/auth.dart';

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
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Error',
          message: e.message != null ? e.message! : e.code,
          contentType: ContentType.failure,
        ),
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const NavigatorView()
      : Scaffold(
          appBar: AppBar(
            title: const Text('Email Verify'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'A verification email has been sent to your email',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 24,
                ),
                if (!canResendEmail) ...[
                  Text(
                    resendCounter.toString(),
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                ],
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50)),
                    icon: Icon(
                      MdiIcons.email,
                      size: 32,
                    ),
                    label: const Text(
                      'Resent Email',
                      style: TextStyle(fontSize: 24),
                    ),
                    onPressed: canResendEmail ? sendVerificationEmail : null),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50)),
                    icon: Icon(
                      MdiIcons.email,
                      size: 32,
                    ),
                    label: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 24),
                    ),
                    onPressed: () => Auth().signOut())
              ],
            ),
          ),
        );
}
