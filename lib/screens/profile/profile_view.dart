import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/user_model.dart';
import 'package:thrill_fit/repository/user_repo.dart';
import 'package:thrill_fit/screens/profile/profile_view_model.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => ProfileViewModel(),
        onViewModelReady: (model) => model.initState(),
        builder: (context, model, _) {
          return model.isBusy
              ? const Center(child: CircularProgressIndicator())
              : StreamProvider<UserModel>.value(
                  value: UserRepo(uid: model.getUser!.uid).userData,
                  initialData: UserModel(
                      age: 0,
                      challengeWins: 0,
                      concecutiveWorkout: 0,
                      email: '',
                      followers: 0,
                      gender: '',
                      height: 0,
                      name: '',
                      phone: '',
                      weight: 0),
                  child: Consumer<UserModel>(
                    builder: (context, data, _) {
                      return Scaffold(
                          appBar: AppBar(),
                          body: SingleChildScrollView(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height + 94.1,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.30,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: (82),
                                          backgroundColor: Colors.transparent,
                                          backgroundImage: NetworkImage(
                                              model.getProfilePictureUrl),
                                        ),
                                        Positioned(
                                          top: 10,
                                          right: 10,
                                          child: IconButton(
                                            icon: Icon(MdiIcons.pencilOutline),
                                            onPressed: () {
                                              model.toggleEdit();
                                            },
                                          ),
                                        ),
                                        if (model.getIsEdit) ...[
                                          CircleAvatar(
                                            radius: (82),
                                            backgroundColor:
                                                Colors.grey.withOpacity(0.5),
                                          ),
                                          IconButton(
                                            icon: Icon(MdiIcons.cameraAccount),
                                            iconSize: 80,
                                            color: Colors.black,
                                            onPressed: () {
                                              model.changeProfilePicture();
                                            },
                                          )
                                        ]
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.14,
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
                                                      width:
                                                          3), // Bottom border
                                                ),
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
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
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    Text(
                                                        '${data.challengeWins}',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                                  ],
                                                )),
                                          ),
                                        ),
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
                                            ),
                                            child: Container(
                                              height: 100,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 3),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    'Concecutive Days Of Workout:',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Text(
                                                      '${data.concecutiveWorkout}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
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
                                                  Text('${data.followers}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                          margin: const EdgeInsets.only(
                                              left: 20, right: 20, top: 40),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text('Name:',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      )),
                                                  Text(data.name,
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                              const Divider(
                                                color: Colors.grey,
                                                thickness: 1,
                                                height: 40,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text('Email:',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      )),
                                                  Text(data.email,
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                              const Divider(
                                                color: Colors.grey,
                                                thickness: 1,
                                                height: 40,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text('Phone:',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      )),
                                                  Text(data.phone,
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                              const Divider(
                                                color: Colors.grey,
                                                thickness: 1,
                                                height: 40,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text('Gender:',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      )),
                                                  Text(data.gender,
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                              const Divider(
                                                color: Colors.grey,
                                                thickness: 1,
                                                height: 40,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text('Height:',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      )),
                                                  Text('${data.height}',
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                              const Divider(
                                                color: Colors.grey,
                                                thickness: 1,
                                                height: 40,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text('Weight:',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      )),
                                                  Text('${data.weight}',
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                              const Divider(
                                                color: Colors.grey,
                                                thickness: 1,
                                                height: 40,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text('Age:',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      )),
                                                  Text('${data.age}',
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                              const Divider(
                                                color: Colors.grey,
                                                thickness: 1,
                                              ),
                                              InkWell(
                                                onTapUp: (_) {
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
                                                              const Center(
                                                                child: Text(
                                                                  'Are you sure you want to logout?',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          24),
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
                                                                              borderRadius: BorderRadius.circular(20),
                                                                              onTapUp: (_) {
                                                                                model.signOut();
                                                                                Navigator.pop(context);
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: const SizedBox(
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
                                                                              borderRadius: BorderRadius.circular(20),
                                                                              onTapUp: (_) {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: const SizedBox(
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
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 10, bottom: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Icon(
                                                        MdiIcons.logout,
                                                        size: 30,
                                                        color: Colors.red,
                                                      ),
                                                      const Text('Sign Out',
                                                          style: TextStyle(
                                                              fontSize: 22,
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const Divider(
                                                color: Colors.grey,
                                                thickness: 1,
                                              ),
                                            ],
                                          ))),
                                ],
                              ),
                            ),
                          ));
                    },
                  ),
                );
        });
  }
}
