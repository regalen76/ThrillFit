import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/post_comments_model.dart';
import 'package:thrill_fit/screens/feeds/feeds_view_model.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:thrill_fit/shared/media_type.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:video_player/video_player.dart';

class FeedsView extends StatelessWidget {
  const FeedsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => FeedsViewModel(),
        builder: (context, model, _) {
          return model.isBusy
              ? const Center(child: CircularProgressIndicator())
              : Scaffold(
                  appBar: AppBar(),
                  body: SizedBox(
                    child: FirestorePagination(
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
                                                        ConnectionState
                                                            .waiting) {
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
                                                            NetworkImage(
                                                                snapshot.data!),
                                                      );
                                                    }
                                                  })))), //profile image
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 10),
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
                                                        ConnectionState
                                                            .waiting) {
                                                      return const SizedBox(
                                                        height: 20,
                                                      );
                                                    } else {
                                                      return SizedBox(
                                                        height: 20,
                                                        child: Text(
                                                          snapshot.data!,
                                                          textAlign:
                                                              TextAlign.start,
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 18),
                                                        ),
                                                      );
                                                    }
                                                  }), //Nama
                                            ),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.80,
                                                child: Text(
                                                  postData.body,
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                )),
                                            Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.80,
                                                margin: const EdgeInsets.only(
                                                    top: 15),
                                                height: 250,
                                                child: PageView.builder(
                                                    itemCount: postData
                                                        .content!.length,
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
                                                                          borderRadius: BorderRadius.circular(
                                                                              20),
                                                                          image:
                                                                              DecorationImage(image: NetworkImage(snapshot.data!))),
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
                                  IconButton(
                                    icon: Icon(
                                      MdiIcons.heartOutline,
                                      size: 25,
                                    ),
                                    onPressed: () {},
                                  ),
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
                                          builder: ((context) {
                                            return SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.7,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: const Text(
                                                      'Comments',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: StreamProvider<
                                                          List<
                                                              PostCommentsModel>>.value(
                                                    value: model
                                                        .getPostCommentsStream(
                                                            dataSnapshot.id),
                                                    initialData: const [],
                                                    child: Consumer<
                                                        List<
                                                            PostCommentsModel>>(
                                                      builder: (context,
                                                          snapshot, _) {
                                                        if (snapshot.isEmpty) {
                                                          return const Center(
                                                              child: Text(
                                                                  "No comments yet"));
                                                        } else {
                                                          return ListView
                                                              .builder(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 10,
                                                                    bottom: 10,
                                                                    right: 10),
                                                            itemCount: snapshot
                                                                .length, // Replace with your actual item count
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return FutureBuilder(
                                                                  future: model
                                                                      .getUserName(
                                                                          postData
                                                                              .author),
                                                                  builder: (context,
                                                                      snapshot2) {
                                                                    if (snapshot2
                                                                            .connectionState ==
                                                                        ConnectionState
                                                                            .waiting) {
                                                                      return const Center(
                                                                          child:
                                                                              CircularProgressIndicator());
                                                                    } else if (snapshot2
                                                                            .connectionState ==
                                                                        ConnectionState
                                                                            .done) {
                                                                      return ListTile(
                                                                        leading:
                                                                            SizedBox(
                                                                          height:
                                                                              40,
                                                                          width:
                                                                              40,
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
                                                                                  return CircleAvatar(
                                                                                    radius: (82),
                                                                                    backgroundColor: Colors.transparent,
                                                                                    backgroundImage: NetworkImage(snapshot3.data!),
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
                                                                        title: Text(
                                                                            snapshot2.data!),
                                                                        subtitle:
                                                                            Text(snapshot[index].comments),
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
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20),
                                                    child: TextField(
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: 'Add comment',
                                                        hintStyle:
                                                            const TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.grey,
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 15),
                                                      ),
                                                      keyboardType:
                                                          TextInputType.text,
                                                      textInputAction:
                                                          TextInputAction.send,
                                                      onSubmitted: (value) {
                                                        model.addComments(
                                                            value,
                                                            dataSnapshot.id,
                                                            model.getUser!.uid);
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }));
                                    },
                                  )
                                ],
                              ))
                            ],
                          );
                        }),
                  ));
        });
  }
}
