import 'package:flutter/material.dart';
import 'package:thrill_fit/models/tester_model.dart';

class TestTileData extends StatelessWidget {
  final TesterModel testerModel;

  const TestTileData({super.key, required this.testerModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "User id: ${testerModel.uid}",
              style: const TextStyle(color: Colors.white),
            ),
           Text(
              "random string: ${testerModel.randString}",
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              "random int: ${testerModel.randInt}",
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
