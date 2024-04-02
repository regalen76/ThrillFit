import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:thrill_fit/screens/profile/profile_view.dart';

class FeedsView extends StatefulWidget {
  const FeedsView({super.key});

  @override
  State<FeedsView> createState() => _FeedsViewState();
}

class _FeedsViewState extends State<FeedsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feeds'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const ProfileView()));
            },
            icon: Icon(
              MdiIcons.accountCircle,
              color: Colors.white,
            ),
            iconSize: 40,
          )
        ],
      ),
      body: Center(
        child: Text('Ini Feeds Page'),
      ),
    );
  }
}
