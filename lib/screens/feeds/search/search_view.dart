import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/user_model.dart';
import 'package:thrill_fit/screens/feeds/search/search_view_model.dart';
import 'package:thrill_fit/screens/profile/guest_profile/guest_profile_view.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => SearchViewModel(),
        onViewModelReady: (model) => model.onInit(),
        onDispose: (model) => model.onDispose(),
        builder: (context, model, _) {
          return model.isBusy
              ? const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                )
              : Scaffold(
                  appBar: AppBar(
                    actions: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          margin: const EdgeInsets.only(left: 60, right: 20),
                          child: TextField(
                            controller: model.getSearhController,
                            autocorrect: false,
                            decoration: const InputDecoration(
                                hintText: 'Search', border: InputBorder.none),
                          ),
                        ),
                      )
                    ],
                  ),
                  body: model.getSearhController.text.isNotEmpty
                      ? FirestorePagination(
                          isLive: true,
                          query: model.getSearchQuery,
                          viewType: ViewType.list,
                          limit: 10,
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 5);
                          },
                          itemBuilder: (context, dataSnapshot, index) {
                            final userData = UserModel.fromJson(
                                dataSnapshot.data() as Map<String, dynamic>);

                            return model.getUserName != userData.name
                                ? InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  GuestProfileView(
                                                      uid: dataSnapshot.id)));
                                    },
                                    child: ListTile(
                                      leading: SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: FutureBuilder(
                                            future:
                                                model.fetchProfilePictureUrl(
                                                    dataSnapshot.id),
                                            builder: (context, snapshot3) {
                                              if (snapshot3.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const CircleAvatar(
                                                  radius: (82),
                                                  backgroundColor: Colors.black,
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              } else if (snapshot3
                                                      .connectionState ==
                                                  ConnectionState.done) {
                                                return CircleAvatar(
                                                  radius: (82),
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  backgroundImage:
                                                      CachedNetworkImageProvider(
                                                          snapshot3.data!),
                                                );
                                              } else {
                                                return const CircleAvatar(
                                                  radius: (82),
                                                  backgroundColor: Colors.black,
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }
                                            }),
                                      ),
                                      title: Text(userData.name),
                                    ))
                                : Container();
                          })
                      : const Center(
                          child: Text('Search User...'),
                        ));
        });
  }
}
