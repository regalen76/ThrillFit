import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:onboarding/onboarding.dart';
import 'package:thrill_fit/screens/widget_tree.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: background,
        appBarTheme: const AppBarTheme(backgroundColor: background),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color(0XFFe0fe0e),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: background,
        appBarTheme: const AppBarTheme(backgroundColor: background),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color(0XFFe0fe0e),
        ),
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const WidgetTree(),
    );
  }
}
