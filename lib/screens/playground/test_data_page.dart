import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thrill_fit/models/tester_model.dart';
import 'package:thrill_fit/screens/playground/test_list_data.dart';
import 'package:thrill_fit/services/auth.dart';
import 'package:thrill_fit/repository/tester_repo.dart';

class TestDataPage extends StatelessWidget {
  TestDataPage({super.key});

  final User? user = Auth().currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<TesterModel>>.value(
      value: TesterRepo(uid: user!.uid).testers,
      initialData: const [],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Playground'),
        ),
        body: const TestListData(),
      ),
    );
  }
}
