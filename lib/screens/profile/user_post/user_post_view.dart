import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/components/comment_modal_view.dart';
import 'package:thrill_fit/screens/profile/guest_profile/guest_profile_view.dart';
import 'package:thrill_fit/screens/profile/user_post/user_post_view_model.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:gesture_x_detector/gesture_x_detector.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thrill_fit/models/post_comments_model.dart';
import 'package:thrill_fit/models/post_likes_model.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:thrill_fit/shared/media_type.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:thrill_fit/shared/util.dart';
import 'package:video_player/video_player.dart';

class UserPostView extends StatelessWidget {
  const UserPostView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => UserPostViewModel(),
        builder: (contextParent, model, _) {
          return model.isBusy
              ? const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                )
              : Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: FirestorePagination(
                      isLive: true,
                      query: model.getPostsQuery,
                      viewType: ViewType.list,
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 25);
                      },
                      itemBuilder: (context, dataSnapshot, index) {
                        final postData = model.mapToPostModel(dataSnapshot);

                        return Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                        width: 60,
                                        height: 60,
                                        margin:
                                            const EdgeInsets.only(left: 7.5),
                                        child: SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: FutureBuilder(
                                                future: model
                                                    .fetchProfilePictureUrl(
                                                        postData.author),
                                                builder: (context, snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return const CircleAvatar(
                                                      radius: (82),
                                                      backgroundColor:
                                                          Colors.black,
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                                  } else {
                                                    return CircleAvatar(
                                                      radius: (82),
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      backgroundImage:
                                                          CachedNetworkImageProvider(
                                                              snapshot.data!),
                                                    );
                                                  }
                                                })))), //profile image
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            child: FutureBuilder(
                                                future: model.getUserName(
                                                    postData.author),
                                                builder: (context, snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return const SizedBox(
                                                      height: 20,
                                                    );
                                                  } else {
                                                    return SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.796,
                                                      height: 30,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            snapshot.data!,
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18),
                                                          ),
                                                          XGestureDetector(
                                                              onTap: (event) {
                                                                showModalBottomSheet(
                                                                    context:
                                                                        context,
                                                                    shape:
                                                                        const RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topLeft:
                                                                            Radius.circular(20),
                                                                        topRight:
                                                                            Radius.circular(20),
                                                                      ),
                                                                    ),
                                                                    builder:
                                                                        ((context) {
                                                                      return SizedBox(
                                                                          height: MediaQuery.of(context).size.height *
                                                                              0.2,
                                                                          width: MediaQuery.of(context)
                                                                              .size
                                                                              .width,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Container(
                                                                                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                                                                                child: InkWell(
                                                                                  onTap: () {
                                                                                    Navigator.pop(context);
                                                                                    showDialog(
                                                                                        context: context,
                                                                                        builder: (BuildContext context) {
                                                                                          return AlertDialog(
                                                                                            insetPadding: EdgeInsets.zero,
                                                                                            contentPadding: EdgeInsets.zero,
                                                                                            content: SizedBox(
                                                                                              height: 200,
                                                                                              width: 100,
                                                                                              child: Column(
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                children: [
                                                                                                  const SizedBox(
                                                                                                    height: 100,
                                                                                                    child: Center(
                                                                                                      child: Text(
                                                                                                        'Delete this post?',
                                                                                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Container(
                                                                                                    height: 50,
                                                                                                    decoration: const BoxDecoration(
                                                                                                      border: Border(
                                                                                                        top: BorderSide(color: Color.fromARGB(31, 158, 158, 158), width: 1),
                                                                                                      ),
                                                                                                    ),
                                                                                                    width: MediaQuery.of(context).size.width,
                                                                                                    child: InkWell(
                                                                                                      onTap: () async {
                                                                                                        await model.deletePost(dataSnapshot.id, postData.content, context).then((value) {
                                                                                                          Util().flashMessageSuccess(contextParent, 'Successfully Deleting Post');
                                                                                                        });
                                                                                                      },
                                                                                                      child: const Center(
                                                                                                        child: Text(
                                                                                                          'Delete',
                                                                                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Container(
                                                                                                    height: 50,
                                                                                                    decoration: const BoxDecoration(
                                                                                                      border: Border(
                                                                                                        top: BorderSide(color: Color.fromARGB(31, 158, 158, 158), width: 1),
                                                                                                      ),
                                                                                                    ),
                                                                                                    width: MediaQuery.of(context).size.width,
                                                                                                    child: InkWell(
                                                                                                      onTap: () {
                                                                                                        Navigator.pop(context);
                                                                                                      },
                                                                                                      child: const Center(
                                                                                                        child: Text(
                                                                                                          'Cancel',
                                                                                                          style: TextStyle(fontWeight: FontWeight.bold),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  )
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          );
                                                                                        });
                                                                                  },
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Icon(
                                                                                        MdiIcons.trashCanOutline,
                                                                                        size: 30,
                                                                                        color: Colors.redAccent,
                                                                                      ),
                                                                                      Container(
                                                                                        margin: const EdgeInsets.only(left: 10),
                                                                                        child: const Text(
                                                                                          'Delete Post',
                                                                                          style: TextStyle(fontSize: 16),
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ));
                                                                    }));
                                                              },
                                                              child: Icon(MdiIcons
                                                                  .dotsVertical))
                                                        ],
                                                      ),
                                                    );
                                                  }
                                                }), //Nama
                                          ),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.796,
                                              child: Text(
                                                postData.body,
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              )),
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.796,
                                              margin: const EdgeInsets.only(
                                                  top: 15),
                                              height: 250,
                                              child: PageView.builder(
                                                  itemCount:
                                                      postData.content!.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final content = postData
                                                        .content![index];

                                                    return Column(
                                                      children: [
                                                        if (MediaType()
                                                            .isImage(content))
                                                          FutureBuilder(
                                                              future: model
                                                                  .fetchContent(
                                                                      content),
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (snapshot
                                                                        .connectionState ==
                                                                    ConnectionState
                                                                        .waiting) {
                                                                  return const Center(
                                                                      child:
                                                                          CircularProgressIndicator());
                                                                } else {
                                                                  return Expanded(
                                                                      child:
                                                                          Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                20),
                                                                        image: DecorationImage(
                                                                            image:
                                                                                CachedNetworkImageProvider(snapshot.data!),
                                                                            fit: BoxFit.contain)),
                                                                  ));
                                                                }
                                                              }),
                                                        if (MediaType()
                                                            .isVideo(content))
                                                          FutureBuilder(
                                                              future: model
                                                                  .fetchContent(
                                                                      content),
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (snapshot
                                                                        .connectionState ==
                                                                    ConnectionState
                                                                        .waiting) {
                                                                  return const Center(
                                                                      child:
                                                                          CircularProgressIndicator());
                                                                } else {
                                                                  final flickManager =
                                                                      FlickManager(
                                                                          videoPlayerController:
                                                                              VideoPlayerController.networkUrl(Uri.parse(snapshot.data!)));

                                                                  return Expanded(
                                                                      child: FlickVideoPlayer(
                                                                          flickManager:
                                                                              flickManager));
                                                                }
                                                              }),
                                                        postData.content!
                                                                    .length !=
                                                                1
                                                            ? Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.80,
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top:
                                                                            10),
                                                                child: Center(
                                                                    child:
                                                                        DotsIndicator(
                                                                  dotsCount: postData
                                                                      .content!
                                                                      .length,
                                                                  position:
                                                                      index,
                                                                  decorator:
                                                                      const DotsDecorator(
                                                                    color: Colors
                                                                        .white, // Inactive color
                                                                    activeColor:
                                                                        Colors
                                                                            .lightBlue,
                                                                  ),
                                                                )),
                                                              )
                                                            : Container()
                                                      ],
                                                    );
                                                  })), //content
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                            SizedBox(
                                child: Row(
                              children: [
                                StreamProvider<List<PostLikesModel>>.value(
                                    value: model.getPostLikesStreamFromUser(
                                        dataSnapshot.id),
                                    initialData: const [],
                                    child: Consumer<List<PostLikesModel>>(
                                      builder: (context, snapshot, _) {
                                        if (snapshot.isEmpty) {
                                          return XGestureDetector(
                                            onTap: (event) {
                                              model.likePost(model.getUser!.uid,
                                                  dataSnapshot.id);
                                            },
                                            longPressTimeConsider: 500,
                                            onLongPress: (event) {
                                              showModalBottomSheet(
                                                  context: context,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(20),
                                                      topRight:
                                                          Radius.circular(20),
                                                    ),
                                                  ),
                                                  builder: ((context) {
                                                    return SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.7,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child: Column(
                                                            children: [
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top:
                                                                            10),
                                                                child:
                                                                    const Text(
                                                                  'Likes',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          18),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                  child: StreamProvider<
                                                                      List<
                                                                          PostLikesModel>>.value(
                                                                value: model
                                                                    .getPostLikesStream(
                                                                        dataSnapshot
                                                                            .id),
                                                                initialData: const [],
                                                                child: Consumer<
                                                                    List<
                                                                        PostLikesModel>>(
                                                                  builder:
                                                                      (context,
                                                                          snapshot,
                                                                          _) {
                                                                    if (snapshot
                                                                        .isEmpty) {
                                                                      return const Center(
                                                                          child:
                                                                              Text("No likes yet"));
                                                                    } else {
                                                                      return ListView
                                                                          .builder(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                10,
                                                                            bottom:
                                                                                10,
                                                                            right:
                                                                                10),
                                                                        itemCount:
                                                                            snapshot.length, // Replace with your actual item count
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          return FutureBuilder(
                                                                              future: model.getUserName(snapshot[index].user),
                                                                              builder: (context, snapshot2) {
                                                                                if (snapshot2.connectionState == ConnectionState.waiting) {
                                                                                  return const Center(child: CircularProgressIndicator());
                                                                                } else if (snapshot2.connectionState == ConnectionState.done) {
                                                                                  return ListTile(
                                                                                    leading: SizedBox(
                                                                                      height: 40,
                                                                                      width: 40,
                                                                                      child: FutureBuilder(
                                                                                          future: model.fetchProfilePictureUrl(snapshot[index].user),
                                                                                          builder: (context, snapshot3) {
                                                                                            if (snapshot3.connectionState == ConnectionState.waiting) {
                                                                                              return const CircleAvatar(
                                                                                                radius: (82),
                                                                                                backgroundColor: Colors.black,
                                                                                                child: CircularProgressIndicator(),
                                                                                              );
                                                                                            } else if (snapshot3.connectionState == ConnectionState.done) {
                                                                                              return GestureDetector(
                                                                                                onTap: () {
                                                                                                  if (snapshot[index].user != model.getUser!.uid) {
                                                                                                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => GuestProfileView(uid: snapshot[index].user)));
                                                                                                  }
                                                                                                },
                                                                                                child: CircleAvatar(
                                                                                                  radius: (82),
                                                                                                  backgroundColor: Colors.transparent,
                                                                                                  backgroundImage: CachedNetworkImageProvider(snapshot3.data!),
                                                                                                ),
                                                                                              );
                                                                                            } else {
                                                                                              return const CircleAvatar(
                                                                                                radius: (82),
                                                                                                backgroundColor: Colors.black,
                                                                                                child: CircularProgressIndicator(),
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
                                                              )),
                                                            ]));
                                                  }));
                                            },
                                            child: Container(
                                                margin: const EdgeInsets.only(
                                                    left: 10),
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Icon(
                                                    MdiIcons.heartOutline,
                                                    size: 25,
                                                  ),
                                                )),
                                          );
                                        } else {
                                          return XGestureDetector(
                                            longPressTimeConsider: 500,
                                            onLongPress: (event) {
                                              showModalBottomSheet(
                                                  context: context,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(20),
                                                      topRight:
                                                          Radius.circular(20),
                                                    ),
                                                  ),
                                                  builder: ((context) {
                                                    return SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.7,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child: Column(
                                                            children: [
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top:
                                                                            10),
                                                                child:
                                                                    const Text(
                                                                  'Likes',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          18),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                  child: StreamProvider<
                                                                      List<
                                                                          PostLikesModel>>.value(
                                                                value: model
                                                                    .getPostLikesStream(
                                                                        dataSnapshot
                                                                            .id),
                                                                initialData: const [],
                                                                child: Consumer<
                                                                    List<
                                                                        PostLikesModel>>(
                                                                  builder:
                                                                      (context,
                                                                          snapshot,
                                                                          _) {
                                                                    if (snapshot
                                                                        .isEmpty) {
                                                                      return const Center(
                                                                          child:
                                                                              Text("No likes yet"));
                                                                    } else {
                                                                      return ListView
                                                                          .builder(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                10,
                                                                            bottom:
                                                                                10,
                                                                            right:
                                                                                10),
                                                                        itemCount:
                                                                            snapshot.length, // Replace with your actual item count
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          return FutureBuilder(
                                                                              future: model.getUserName(snapshot[index].user),
                                                                              builder: (context, snapshot2) {
                                                                                if (snapshot2.connectionState == ConnectionState.waiting) {
                                                                                  return const Center(child: CircularProgressIndicator());
                                                                                } else if (snapshot2.connectionState == ConnectionState.done) {
                                                                                  return ListTile(
                                                                                    leading: SizedBox(
                                                                                      height: 40,
                                                                                      width: 40,
                                                                                      child: FutureBuilder(
                                                                                          future: model.fetchProfilePictureUrl(snapshot[index].user),
                                                                                          builder: (context, snapshot3) {
                                                                                            if (snapshot3.connectionState == ConnectionState.waiting) {
                                                                                              return const CircleAvatar(
                                                                                                radius: (82),
                                                                                                backgroundColor: Colors.black,
                                                                                                child: CircularProgressIndicator(),
                                                                                              );
                                                                                            } else if (snapshot3.connectionState == ConnectionState.done) {
                                                                                              return GestureDetector(
                                                                                                onTap: () {
                                                                                                  if (snapshot[index].user != model.getUser!.uid) {
                                                                                                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => GuestProfileView(uid: snapshot[index].user)));
                                                                                                  }
                                                                                                },
                                                                                                child: CircleAvatar(
                                                                                                  radius: (82),
                                                                                                  backgroundColor: Colors.transparent,
                                                                                                  backgroundImage: CachedNetworkImageProvider(snapshot3.data!),
                                                                                                ),
                                                                                              );
                                                                                            } else {
                                                                                              return const CircleAvatar(
                                                                                                radius: (82),
                                                                                                backgroundColor: Colors.black,
                                                                                                child: CircularProgressIndicator(),
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
                                                              )),
                                                            ]));
                                                  }));
                                            },
                                            onTap: (event) {
                                              model.unlikePost(
                                                  model.getUser!.uid,
                                                  dataSnapshot.id);
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  left: 10),
                                              child: InkWell(
                                                onTap: () {},
                                                child: Icon(
                                                  MdiIcons.heart,
                                                  color: Colors.pink,
                                                  size: 25,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    )),
                                StreamProvider<List<PostLikesModel>>.value(
                                    value: model
                                        .getPostLikesStream(dataSnapshot.id),
                                    initialData: const [],
                                    child: Consumer<List<PostLikesModel>>(
                                        builder: (context, snapshot, _) {
                                      if (snapshot.isNotEmpty) {
                                        return Container(
                                          margin:
                                              const EdgeInsets.only(left: 10),
                                          child:
                                              Text('${snapshot.length} likes'),
                                        );
                                      } else {
                                        return const SizedBox();
                                      }
                                    })),
                                IconButton(
                                  icon: Icon(MdiIcons.messageTextOutline,
                                      size: 25),
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                      ),
                                      isScrollControlled:
                                          true, // This is important to allow the sheet to resize with the keyboard
                                      builder: (context) {
                                        return CommentModalView(
                                            postId: dataSnapshot.id);
                                      },
                                    );
                                  },
                                ),
                                StreamProvider<List<PostCommentsModel>>.value(
                                    value: model
                                        .getPostCommentsStream(dataSnapshot.id),
                                    initialData: const [],
                                    child: Consumer<List<PostCommentsModel>>(
                                        builder: (context, snapshot, _) {
                                      if (snapshot.isNotEmpty) {
                                        return Text(
                                            '${snapshot.length} comments');
                                      } else {
                                        return const SizedBox();
                                      }
                                    }))
                              ],
                            ))
                          ],
                        );
                      }),
                );
        });
  }
}
