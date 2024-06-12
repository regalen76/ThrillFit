import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/screens/feeds/feeds_view_model.dart';
import 'package:thrill_fit/screens/feeds/followers/feeds_followers_view.dart';
import 'package:thrill_fit/screens/feeds/timeline/feeds_timeline_view.dart';
import 'package:thrill_fit/screens/profile/profile_view.dart';
import 'package:thrill_fit/screens/feeds/search/search_view.dart';

class FeedsView extends StatelessWidget {
  const FeedsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => FeedsViewModel(),
        builder: (context, model, _) {
          return model.isBusy
              ? const Center(child: CircularProgressIndicator())
              : DefaultTabController(
                  length: 2,
                  child: Scaffold(
                    appBar: AppBar(
                      title: const Text('Feeds'),
                      actions: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const SearchView()));
                          },
                          icon: Icon(
                            MdiIcons.magnify,
                            color: Colors.white,
                          ),
                          iconSize: 40,
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const ProfileView()));
                          },
                          icon: Icon(
                            MdiIcons.accountCircle,
                            color: Colors.white,
                          ),
                          iconSize: 40,
                        )
                      ],
                      bottom: const TabBar(
                        tabs: [
                          Tab(
                            child: Text(
                              'Timeline',
                              style: TextStyle(fontSize: 19),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Followed',
                              style: TextStyle(fontSize: 19),
                            ),
                          ),
                        ],
                      ),
                    ),
                    body: const TabBarView(
                      children: [
                        FeedsTimelineView(),
                        FeedsFollowersView(),
                      ],
                    ),
                  ),
                );
        });
  }
}
