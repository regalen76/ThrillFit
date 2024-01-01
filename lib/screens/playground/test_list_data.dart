import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thrill_fit/models/tester_model.dart';
import 'package:thrill_fit/screens/playground/test_tile_data.dart';

class TestListData extends StatefulWidget {
  const TestListData({super.key});

  @override
  State<TestListData> createState() => _TestListDataState();
}

class _TestListDataState extends State<TestListData> {
  @override
  Widget build(BuildContext context) {

    final testerModels = Provider.of<List<TesterModel>>(context);

    return ListView.builder(
      itemCount: testerModels.length,
      itemBuilder: (context, index) {
        return TestTileData(testerModel: testerModels[index],);
      },
    );
  }
}
