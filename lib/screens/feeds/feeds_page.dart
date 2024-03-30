import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:thrill_fit/screens/profile/profile_page.dart';

class FeedsPage extends StatefulWidget {
  const FeedsPage({super.key});

  @override
  State<FeedsPage> createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> {
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
                      builder: (BuildContext context) => const ProfilePage()));
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
