import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/components/comment_modal_view_model.dart';
import 'package:thrill_fit/models/post_comments_model.dart';
import 'package:thrill_fit/screens/profile/guest_profile/guest_profile_view.dart';
import 'package:thrill_fit/screens/profile/profile_view.dart';

class CommentModalView extends StatelessWidget {
  final String postId;
  const CommentModalView({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => CommentModalViewModel(postId: postId),
        onViewModelReady: (model) => model.initState(),
        onDispose: (model) => model.disposeAll(),
        builder: (context, model, _) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context)
                  .viewInsets
                  .bottom, // Adjust for the keyboard
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: const Text(
                      'Comments',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                      child: StreamProvider<List<PostCommentsModel>>.value(
                        value: model.getPostCommentsStream,
                        initialData: const [],
                        child: Consumer<List<PostCommentsModel>>(
                          builder: (context, snapshot, _) {
                            if (snapshot.isEmpty) {
                              return Container(
                                  height: MediaQuery.of(context).size.height,
                                  color: Colors.transparent,
                                  child: const Center(
                                      child: Text("No comments yet")));
                            } else {
                              return ListView.builder(
                                padding: const EdgeInsets.only(
                                    left: 10, bottom: 10, right: 10),
                                itemCount: snapshot
                                    .length, // Replace with your actual item count
                                itemBuilder: (context, index) {
                                  return FutureBuilder(
                                    future:
                                        model.getUserName(snapshot[index].user),
                                    builder: (context, snapshot2) {
                                      if (snapshot2.connectionState ==
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
                                                              .user ==
                                                          model.getUser!.uid) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    const ProfileView()));
                                                      } else {
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
                                                          CachedNetworkImageProvider(
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
                                              },
                                            ),
                                          ),
                                          title: Text(snapshot2.data!),
                                          subtitle:
                                              Text(snapshot[index].comments),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    },
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      controller: model.commentField,
                      decoration: InputDecoration(
                        hintText: 'Add comment',
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 15),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (value) async {
                        await model.addComments(
                            value, postId, model.getUser!.uid);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
