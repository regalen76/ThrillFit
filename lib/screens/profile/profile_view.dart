import 'package:flutter/material.dart';
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
                          appBar: AppBar(
                            title: const Text('Profile'),
                          ),
                          body: SingleChildScrollView(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height,
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
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey, width: 3),
                                            ),
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
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey, width: 3),
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
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey, width: 3),
                                            ),
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
                                            ],
                                          ))),
                                  ElevatedButton(
                                      onPressed: () {
                                        model.signOut();
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Sign Out')),
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
