import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thrill_fit/shared/util.dart';

import '../../services/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool isLogin = true;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  String? validateEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can`t be empty';
    }
    return null;
  }

  Future<void> signInWithEmailAndPassword() async {
    if (formKey.currentState!.validate()) {
      try {
        await Auth().signInWithEmailAndPassword(
            email: controllerEmail.text.trim(),
            password: controllerPassword.text.trim());
      } on FirebaseAuthException catch (e) {
        if (mounted) {
          if (e.code == 'invalid-credential') {
            Util().flashMessageError(context, 'Invalid Credentials');
          } else if (e.code == 'invalid-email') {
            Util().flashMessageError(context, 'Invalid Email');
          } else if (e.code == 'wrong-password') {
            Util().flashMessageError(context, 'Wrong Password');
          } else {
            Util().flashMessageError(context, e.code);
          }
        }
      }
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    if (formKey.currentState!.validate()) {
      try {
        await Auth().createUserWithEmailAndPassword(
            email: controllerEmail.text.trim(),
            password: controllerPassword.text.trim());
      } on FirebaseAuthException catch (e) {
        if (mounted) {
          if (e.message == null) {
            Util().flashMessageError(context, e.code);
          } else {
            Util().flashMessageError(context, e.message!);
          }
        }
      }
    }
  }

  TextFormField entryField(String title, TextEditingController controller) {
    return TextFormField(
      autocorrect: false,
      validator: validateEmpty,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      enableSuggestions: false,
      keyboardType: TextInputType.visiblePassword,
      controller: controller,
      style: const TextStyle(color: Colors.white, fontSize: 22),
      decoration: InputDecoration(
          labelText: title,
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 19)),
    );
  }

  TextFormField entryFieldPassword(
      String title, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: validateEmpty,
      obscureText: true,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      enableSuggestions: false,
      autocorrect: false,
      style: const TextStyle(color: Colors.white, fontSize: 22),
      decoration: InputDecoration(
          labelText: title,
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 19)),
    );
  }

  Widget submitButton() {
    return GestureDetector(
      onTap:
          isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
      child: AnimatedContainer(
        margin: const EdgeInsets.only(top: 30, bottom: 30),
        duration: const Duration(seconds: 1),
        width: MediaQuery.of(context).size.width,
        height: 65,
        decoration: BoxDecoration(
          color: isLogin ? Colors.blue : Colors.deepPurpleAccent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            isLogin ? 'Login' : 'Register',
            style: const TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
    );
  }

  Widget loginOrRegisterButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        width: MediaQuery.of(context).size.width,
        height: 65,
        decoration: BoxDecoration(
          color: isLogin ? Colors.deepPurpleAccent : Colors.blue,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            isLogin ? 'Register Instead' : 'Login Instead',
            style: const TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Authentication'),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  child: Icon(
                    Icons.account_circle,
                    key: ValueKey<bool>(isLogin),
                    color: isLogin ? Colors.blue : Colors.deepPurpleAccent,
                    size: 250,
                  ),
                ),
                entryField('email', controllerEmail),
                entryFieldPassword('password', controllerPassword),
                submitButton(),
                loginOrRegisterButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
