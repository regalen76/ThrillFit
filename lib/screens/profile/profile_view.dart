import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/screens/profile/profile_data/profile_data_view.dart';
import 'package:thrill_fit/screens/profile/profile_view_model.dart';
import 'package:thrill_fit/screens/profile/user_post/user_post_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => ProfileViewModel(),
        builder: (context, model, _) {
          return model.isBusy
              ? const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                )
              : DefaultTabController(
                  length: 2,
                  child: Scaffold(
                    appBar: AppBar(
                      title: const Text('User'),
                      bottom: const TabBar(
                        tabs: [
                          Tab(
                            child: Text(
                              'Profile',
                              style: TextStyle(fontSize: 19),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Posts',
                              style: TextStyle(fontSize: 19),
                            ),
                          ),
                        ],
                      ),
                    ),
                    body: const TabBarView(
                      children: [
                        ProfileDataView(),
                        UserPostView(),
                      ],
                    ),
                  ),
                );
        });
  }
}
