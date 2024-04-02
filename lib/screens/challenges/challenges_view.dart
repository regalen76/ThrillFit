import 'package:flutter/material.dart';

class ChallengesView extends StatefulWidget {
  const ChallengesView({super.key});

  @override
  State<ChallengesView> createState() => _ChallengesViewState();
}

class _ChallengesViewState extends State<ChallengesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Challenges'),
      ),
      body: Center(
        child: Text('Ini Challenges Page'),
      ),
    );
  }
}
