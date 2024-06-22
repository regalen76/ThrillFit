import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/followers_model.dart';
import 'package:thrill_fit/repository/user_repo.dart';
import 'package:thrill_fit/screens/profile/followers/followers_view_model.dart';
import 'package:thrill_fit/screens/profile/guest_profile/guest_profile_view.dart';

class FollowersView extends StatelessWidget {
  final String uid;

  const FollowersView({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => FollowersViewModel(userUid: uid),
        builder: (context, model, _) {
          return model.isBusy
              ? const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                )
              : Scaffold(
                  appBar: AppBar(
                    title: const Text('Followers'),
                    backgroundColor: Colors.black,
                  ),
                  body: StreamProvider<List<FollowersModel>>.value(
                    value: UserRepo(uid: model.getUser!.uid)
                        .getFollowersStream(uid),
                    initialData: const [],
                    child: Consumer<List<FollowersModel>>(
                      builder: (context, snapshot, _) {
                        if (!snapshot.isNotEmpty) {
                          return const Center(child: Text("No followers yet"));
                        } else {
                          return ListView.builder(
                            padding: const EdgeInsets.only(
                                left: 10, bottom: 10, right: 10),
                            itemCount: snapshot.length,
                            itemBuilder: (context, index) {
                              return FutureBuilder(
                                  future:
                                      model.getUserName(snapshot[index].user),
                                  builder: (context, snapshot2) {
                                    if (snapshot2.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else if (snapshot2.connectionState ==
                                        ConnectionState.done) {
                                      return ListTile(
                                        leading: SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: FutureBuilder(
                                              future:
                                                  model.fetchProfilePictureUrl(
                                                      snapshot[index].user),
                                              builder: (context, snapshot3) {
                                                if (snapshot3.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const CircleAvatar(
                                                    radius: (82),
                                                    backgroundColor:
                                                        Colors.black,
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                } else if (snapshot3
                                                        .connectionState ==
                                                    ConnectionState.done) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      if (snapshot[index]
                                                                  .user !=
                                                              model.getUser!
                                                                  .uid &&
                                                          snapshot[index]
                                                                  .user !=
                                                              uid) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    GuestProfileView(
                                                                        uid: snapshot[index]
                                                                            .user)));
                                                      }
                                                    },
                                                    child: CircleAvatar(
                                                      radius: (82),
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      backgroundImage:
                                                          NetworkImage(
                                                              snapshot3.data!),
                                                    ),
                                                  );
                                                } else {
                                                  return const CircleAvatar(
                                                    radius: (82),
                                                    backgroundColor:
                                                        Colors.black,
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                }
                                              }),
                                        ),
                                        title: Text(snapshot2.data!),
                                      );
                                    } else {
                                      return const CircularProgressIndicator();
                                    }
                                  });
                            },
                          );
                        }
                      },
                    ),
                  ));
        });
  }
}
