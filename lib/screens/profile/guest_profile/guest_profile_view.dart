import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:gesture_x_detector/gesture_x_detector.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/components/comment_modal_view.dart';
import 'package:thrill_fit/models/followers_model.dart';
import 'package:thrill_fit/models/post_comments_model.dart';
import 'package:thrill_fit/models/post_likes_model.dart';
import 'package:thrill_fit/models/user_model.dart';
import 'package:thrill_fit/repository/user_repo.dart';
import 'package:thrill_fit/screens/profile/followers/followers_view.dart';
import 'package:thrill_fit/screens/profile/following/following_view.dart';
import 'package:thrill_fit/screens/profile/guest_profile/guest_profile_view_model.dart';
import 'package:thrill_fit/shared/media_type.dart';
import 'package:video_player/video_player.dart';

class GuestProfileView extends StatelessWidget {
  final String uid;
  const GuestProfileView({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => GuestProfileViewModel(userUid: uid),
        onViewModelReady: (model) => model.initState(),
        builder: (context, model, _) {
          return model.isBusy
              ? const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                )
              : StreamProvider<UserModel>.value(
                  value: UserRepo(uid: uid).userData,
                  initialData: UserModel(
                      age: 0,
                      challengeWins: 0,
                      concecutiveWorkout: 0,
                      email: '',
                      followers: 0,
                      gender: '',
                      height: 0,
                      name: '',
                      nameSearch: [],
                      phone: '',
                      weight: 0),
                  child: Consumer<UserModel>(
                    builder: (context, data, _) {
                      return Scaffold(
                        appBar: AppBar(
                          title: Text(data.name),
                        ),
                        body: SingleChildScrollView(
                          child: SizedBox(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.225,
                                  width: MediaQuery.of(context).size.width,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: (82),
                                        backgroundColor: Colors.transparent,
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                                model.getProfilePictureUrl),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.only(bottom: 15),
                                  child: Center(
                                    child: StreamProvider<
                                            List<FollowersModel>>.value(
                                        value: UserRepo(uid: model.getUser!.uid)
                                            .getFollowersStreamFromUser(
                                                uid, model.getUser!.uid),
                                        initialData: const [],
                                        child: Consumer<List<FollowersModel>>(
                                            builder:
                                                (context, followersData, _) {
                                          if (followersData.isEmpty) {
                                            return ElevatedButton(
                                                style: ButtonStyle(
                                                    minimumSize: MaterialStateProperty.all<Size>(
                                                        const Size(150, 45)),
                                                    backgroundColor:
                                                        MaterialStateProperty.all<
                                                            Color>(Colors.blue),
                                                    foregroundColor:
                                                        MaterialStateProperty.all<Color>(
                                                            Colors.white),
                                                    shape: MaterialStateProperty.all<OutlinedBorder>(
                                                        ContinuousRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(20.0)))),
                                                onPressed: () {
                                                  UserRepo(
                                                          uid: model
                                                              .getUser!.uid)
                                                      .createFollowersData(uid,
                                                          model.getUser!.uid);
                                                },
                                                child: const Text('Follow'));
                                          } else {
                                            return OutlinedButton(
                                              style: ButtonStyle(
                                                minimumSize:
                                                    MaterialStateProperty.all<
                                                        Size>(
                                                  const Size(150, 45),
                                                ),
                                                side: MaterialStateProperty.all<
                                                    BorderSide>(
                                                  const BorderSide(
                                                      color: Colors.grey,
                                                      width: 2),
                                                ),
                                                foregroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Colors.grey),
                                                shape: MaterialStateProperty
                                                    .all<OutlinedBorder>(
                                                  ContinuousRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                ),
                                              ),
                                              onPressed: () {
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
                                                      height: 300,
                                                      child: Center(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Center(
                                                              child: Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            20,
                                                                        right:
                                                                            20),
                                                                child: Text(
                                                                  'Are you want to unfollow ${data.name}?',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          24),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top:
                                                                            40),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Material(
                                                                          borderRadius:
                                                                              BorderRadius.circular(20),
                                                                          child:
                                                                              InkWell(
                                                                            borderRadius:
                                                                                BorderRadius.circular(20),
                                                                            onTapUp:
                                                                                (_) async {
                                                                              await UserRepo(uid: model.getUser!.uid).deleteFollowersData(uid, model.getUser!.uid);
                                                                              if (context.mounted) {
                                                                                Navigator.pop(context);
                                                                              }
                                                                            },
                                                                            child:
                                                                                const SizedBox(
                                                                              height: 80,
                                                                              width: 170,
                                                                              child: Center(
                                                                                child: Text('Yes'),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Material(
                                                                          borderRadius:
                                                                              BorderRadius.circular(20),
                                                                          child:
                                                                              InkWell(
                                                                            borderRadius:
                                                                                BorderRadius.circular(20),
                                                                            onTapUp:
                                                                                (_) {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                const SizedBox(
                                                                              height: 80,
                                                                              width: 170,
                                                                              child: Center(
                                                                                child: Text('No'),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                                );
                                              },
                                              child: const Text('Followed'),
                                            );
                                          }
                                        })),
                                  ),
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.14,
                                  margin: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              border: Border(
                                                top: BorderSide(
                                                    color: Colors.grey,
                                                    width: 3), // Top border
                                                left: BorderSide(
                                                    color: Colors.grey,
                                                    width: 3), // Left border
                                                bottom: BorderSide(
                                                    color: Colors.grey,
                                                    width: 3), // Bottom border
                                              ),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10))),
                                          child: SizedBox(
                                              height: 100,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    'Challenge Wins:',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Text('${data.challengeWins}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold))
                                                ],
                                              )),
                                        ),
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTapUp: (_) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        FollowingView(
                                                          uid: uid,
                                                        )));
                                          },
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                top: BorderSide(
                                                    color: Colors.grey,
                                                    width: 3), // Top border
                                                left: BorderSide(
                                                    color: Colors.grey,
                                                    width: 3),
                                                bottom: BorderSide(
                                                    color: Colors.grey,
                                                    width: 3), // Bottom border
                                              ),
                                            ),
                                            child: SizedBox(
                                              height: 100,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    'Following:',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  StreamProvider<
                                                          List<
                                                              FollowersModel>>.value(
                                                      value: UserRepo(
                                                              uid: model
                                                                  .getUser!.uid)
                                                          .getFollowedStream(
                                                              uid),
                                                      initialData: const [],
                                                      child: Consumer<
                                                              List<
                                                                  FollowersModel>>(
                                                          builder: (context,
                                                              followersData,
                                                              _) {
                                                        if (followersData
                                                            .isNotEmpty) {
                                                          return Text(
                                                              '${followersData.length}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: const TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold));
                                                        } else {
                                                          return const Text('0',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold));
                                                        }
                                                      })),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTapUp: (_) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        FollowersView(
                                                          uid: uid,
                                                        )));
                                          },
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                border: Border(
                                                    top: BorderSide(
                                                        color: Colors.grey,
                                                        width: 3), // Top border
                                                    left: BorderSide(
                                                        color: Colors.grey,
                                                        width: 3),
                                                    bottom: BorderSide(
                                                        color: Colors.grey,
                                                        width:
                                                            3), // Bottom border
                                                    right: BorderSide(
                                                        color: Colors.grey,
                                                        width: 3)),
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10))),
                                            child: SizedBox(
                                              height: 100,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    'Followers:',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  StreamProvider<
                                                          List<
                                                              FollowersModel>>.value(
                                                      value: UserRepo(
                                                              uid: model
                                                                  .getUser!.uid)
                                                          .getFollowersStream(
                                                              uid),
                                                      initialData: const [],
                                                      child: Consumer<
                                                              List<
                                                                  FollowersModel>>(
                                                          builder: (context,
                                                              followersData,
                                                              _) {
                                                        if (followersData
                                                            .isNotEmpty) {
                                                          return Text(
                                                              '${followersData.length}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: const TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold));
                                                        } else {
                                                          return const Text('0',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold));
                                                        }
                                                      })),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  child: FirestorePagination(
                                      isLive: true,
                                      query: model.getPostsQuery(),
                                      viewType: ViewType.wrap,
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(height: 25);
                                      },
                                      itemBuilder:
                                          (context, dataSnapshot, index) {
                                        final postData =
                                            model.mapToPostModel(dataSnapshot);

                                        return Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Align(
                                                    alignment:
                                                        Alignment.topCenter,
                                                    child: Container(
                                                        width: 60,
                                                        height: 60,
                                                        margin: const EdgeInsets
                                                            .only(left: 7.5),
                                                        child: SizedBox(
                                                            width: 50,
                                                            height: 50,
                                                            child:
                                                                FutureBuilder(
                                                                    future: model.fetchProfilePictureUrl(
                                                                        postData
                                                                            .author),
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      if (snapshot
                                                                              .connectionState ==
                                                                          ConnectionState
                                                                              .waiting) {
                                                                        return const CircleAvatar(
                                                                          radius:
                                                                              (82),
                                                                          backgroundColor:
                                                                              Colors.black,
                                                                          child:
                                                                              CircularProgressIndicator(),
                                                                        );
                                                                      } else {
                                                                        return CircleAvatar(
                                                                          radius:
                                                                              (82),
                                                                          backgroundColor:
                                                                              Colors.transparent,
                                                                          backgroundImage:
                                                                              CachedNetworkImageProvider(snapshot.data!),
                                                                        );
                                                                      }
                                                                    })))), //profile image
                                                Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 10,
                                                              right: 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    bottom: 10),
                                                            child:
                                                                FutureBuilder(
                                                                    future: model.getUserName(
                                                                        postData
                                                                            .author),
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      if (snapshot
                                                                              .connectionState ==
                                                                          ConnectionState
                                                                              .waiting) {
                                                                        return const SizedBox(
                                                                          height:
                                                                              20,
                                                                        );
                                                                      } else {
                                                                        return SizedBox(
                                                                          height:
                                                                              20,
                                                                          child:
                                                                              Text(
                                                                            snapshot.data!,
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            style:
                                                                                const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                                                          ),
                                                                        );
                                                                      }
                                                                    }), //Nama
                                                          ),
                                                          SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.796,
                                                              child: Text(
                                                                postData.body,
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            16),
                                                              )),
                                                          Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.796,
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 15),
                                                              height: 250,
                                                              child: PageView
                                                                  .builder(
                                                                      itemCount: postData
                                                                          .content!
                                                                          .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        final content =
                                                                            postData.content![index];

                                                                        return Column(
                                                                          children: [
                                                                            if (MediaType().isImage(content))
                                                                              FutureBuilder(
                                                                                  future: model.fetchContent(content),
                                                                                  builder: (context, snapshot) {
                                                                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                                                                      return const Center(child: CircularProgressIndicator());
                                                                                    } else {
                                                                                      return Expanded(
                                                                                          child: Container(
                                                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), image: DecorationImage(image: CachedNetworkImageProvider(snapshot.data!), fit: BoxFit.contain)),
                                                                                      ));
                                                                                    }
                                                                                  }),
                                                                            if (MediaType().isVideo(content))
                                                                              FutureBuilder(
                                                                                  future: model.fetchContent(content),
                                                                                  builder: (context, snapshot) {
                                                                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                                                                      return const Center(child: CircularProgressIndicator());
                                                                                    } else {
                                                                                      final flickManager = FlickManager(videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(snapshot.data!)));

                                                                                      return Expanded(child: FlickVideoPlayer(flickManager: flickManager));
                                                                                    }
                                                                                  }),
                                                                            postData.content!.length != 1
                                                                                ? Container(
                                                                                    width: MediaQuery.of(context).size.width * 0.80,
                                                                                    margin: const EdgeInsets.only(top: 10),
                                                                                    child: Center(
                                                                                        child: DotsIndicator(
                                                                                      dotsCount: postData.content!.length,
                                                                                      position: index,
                                                                                      decorator: const DotsDecorator(
                                                                                        color: Colors.white, // Inactive color
                                                                                        activeColor: Colors.lightBlue,
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
                                                StreamProvider<
                                                        List<
                                                            PostLikesModel>>.value(
                                                    value: model
                                                        .getPostLikesStreamFromUser(
                                                            dataSnapshot.id),
                                                    initialData: const [],
                                                    child: Consumer<
                                                        List<PostLikesModel>>(
                                                      builder: (context,
                                                          snapshot, _) {
                                                        if (snapshot.isEmpty) {
                                                          return XGestureDetector(
                                                            onTap: (event) {
                                                              model.likePost(
                                                                  model.getUser!
                                                                      .uid,
                                                                  dataSnapshot
                                                                      .id);
                                                            },
                                                            longPressTimeConsider:
                                                                500,
                                                            onLongPress:
                                                                (event) {
                                                              showModalBottomSheet(
                                                                  context:
                                                                      context,
                                                                  shape:
                                                                      const RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              20),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              20),
                                                                    ),
                                                                  ),
                                                                  builder:
                                                                      ((context) {
                                                                    return SizedBox(
                                                                        height: MediaQuery.of(context).size.height *
                                                                            0.7,
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width,
                                                                        child: Column(
                                                                            children: [
                                                                              Container(
                                                                                margin: const EdgeInsets.only(top: 10),
                                                                                child: const Text(
                                                                                  'Likes',
                                                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                                                                ),
                                                                              ),
                                                                              Expanded(
                                                                                  child: StreamProvider<List<PostLikesModel>>.value(
                                                                                value: model.getPostLikesStream(dataSnapshot.id),
                                                                                initialData: const [],
                                                                                child: Consumer<List<PostLikesModel>>(
                                                                                  builder: (context, snapshot, _) {
                                                                                    if (snapshot.isEmpty) {
                                                                                      return const Center(child: Text("No likes yet"));
                                                                                    } else {
                                                                                      return ListView.builder(
                                                                                        padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                                                                                        itemCount: snapshot.length, // Replace with your actual item count
                                                                                        itemBuilder: (context, index) {
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
                                                                                                                  if (snapshot[index].user != uid) {
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
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            10),
                                                                child: InkWell(
                                                                  onTap: () {},
                                                                  child: Icon(
                                                                    MdiIcons
                                                                        .heartOutline,
                                                                    size: 25,
                                                                  ),
                                                                )),
                                                          );
                                                        } else {
                                                          return XGestureDetector(
                                                            longPressTimeConsider:
                                                                500,
                                                            onLongPress:
                                                                (event) {
                                                              showModalBottomSheet(
                                                                  context:
                                                                      context,
                                                                  shape:
                                                                      const RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              20),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              20),
                                                                    ),
                                                                  ),
                                                                  builder:
                                                                      ((context) {
                                                                    return SizedBox(
                                                                        height: MediaQuery.of(context).size.height *
                                                                            0.7,
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width,
                                                                        child: Column(
                                                                            children: [
                                                                              Container(
                                                                                margin: const EdgeInsets.only(top: 10),
                                                                                child: const Text(
                                                                                  'Likes',
                                                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                                                                ),
                                                                              ),
                                                                              Expanded(
                                                                                  child: StreamProvider<List<PostLikesModel>>.value(
                                                                                value: model.getPostLikesStream(dataSnapshot.id),
                                                                                initialData: const [],
                                                                                child: Consumer<List<PostLikesModel>>(
                                                                                  builder: (context, snapshot, _) {
                                                                                    if (snapshot.isEmpty) {
                                                                                      return const Center(child: Text("No likes yet"));
                                                                                    } else {
                                                                                      return ListView.builder(
                                                                                        padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                                                                                        itemCount: snapshot.length, // Replace with your actual item count
                                                                                        itemBuilder: (context, index) {
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
                                                                                                                  if (snapshot[index].user != uid && snapshot[index].user != model.getUser!.uid) {
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
                                                                  model.getUser!
                                                                      .uid,
                                                                  dataSnapshot
                                                                      .id);
                                                            },
                                                            child: Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 10),
                                                              child: InkWell(
                                                                onTap: () {},
                                                                child: Icon(
                                                                  MdiIcons
                                                                      .heart,
                                                                  color: Colors
                                                                      .pink,
                                                                  size: 25,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      },
                                                    )),
                                                StreamProvider<
                                                        List<
                                                            PostLikesModel>>.value(
                                                    value: model
                                                        .getPostLikesStream(
                                                            dataSnapshot.id),
                                                    initialData: const [],
                                                    child: Consumer<
                                                            List<
                                                                PostLikesModel>>(
                                                        builder: (context,
                                                            snapshot, _) {
                                                      if (snapshot.isNotEmpty) {
                                                        return Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10),
                                                          child: Text(
                                                              '${snapshot.length} likes'),
                                                        );
                                                      } else {
                                                        return const SizedBox();
                                                      }
                                                    })),
                                                IconButton(
                                                  icon: Icon(
                                                      MdiIcons
                                                          .messageTextOutline,
                                                      size: 25),
                                                  onPressed: () {
                                                    showModalBottomSheet(
                                                      context: context,
                                                      shape:
                                                          const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20),
                                                          topRight:
                                                              Radius.circular(
                                                                  20),
                                                        ),
                                                      ),
                                                      isScrollControlled:
                                                          true, // This is important to allow the sheet to resize with the keyboard
                                                      builder: (context) {
                                                        return CommentModalView(
                                                            postId: dataSnapshot
                                                                .id);
                                                      },
                                                    );
                                                  },
                                                ),
                                                StreamProvider<
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
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
        });
  }
}
