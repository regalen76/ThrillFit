import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/models/followers_model.dart';
import 'package:thrill_fit/models/user_model.dart';
import 'package:thrill_fit/repository/user_repo.dart';
import 'package:thrill_fit/screens/profile/followers/followers_view.dart';
import 'package:thrill_fit/screens/profile/following/following_view.dart';
import 'package:thrill_fit/screens/profile/profile_data/profile_data_view_model.dart';

class ProfileDataView extends StatelessWidget {
  const ProfileDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => ProfileDataViewModel(),
        onViewModelReady: (model) => model.initState(),
        onDispose: (model) => model.disposeAll(),
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
                      nameSearch: [],
                      phone: '',
                      weight: 0),
                  child: Consumer<UserModel>(
                    builder: (context, data, _) {
                      return SingleChildScrollView(
                        child: SizedBox(
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.30,
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
                                height:
                                    MediaQuery.of(context).size.height * 0.14,
                                margin:
                                    const EdgeInsets.only(left: 20, right: 20),
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
                                                    textAlign: TextAlign.center,
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
                                                  builder:
                                                      (BuildContext context) =>
                                                          FollowingView(
                                                            uid: model
                                                                .getUser!.uid,
                                                          )));
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                  color: Colors.grey,
                                                  width: 3), // Top border
                                              left: BorderSide(
                                                  color: Colors.grey, width: 3),
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
                                                            model.getUser!.uid),
                                                    initialData: const [],
                                                    child: Consumer<
                                                            List<
                                                                FollowersModel>>(
                                                        builder: (context,
                                                            followersData, _) {
                                                      if (followersData
                                                          .isNotEmpty) {
                                                        return Text(
                                                            '${followersData.length}',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: const TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold));
                                                      } else {
                                                        return const Text('0',
                                                            textAlign: TextAlign
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
                                                  builder:
                                                      (BuildContext context) =>
                                                          FollowersView(
                                                            uid: model
                                                                .getUser!.uid,
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
                                                  topRight: Radius.circular(10),
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
                                                            model.getUser!.uid),
                                                    initialData: const [],
                                                    child: Consumer<
                                                            List<
                                                                FollowersModel>>(
                                                        builder: (context,
                                                            followersData, _) {
                                                      if (followersData
                                                          .isNotEmpty) {
                                                        return Text(
                                                            '${followersData.length}',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: const TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold));
                                                      } else {
                                                        return const Text('0',
                                                            textAlign: TextAlign
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
                              SizedBox(
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 20, right: 20, top: 40),
                                      child: Form(
                                        key: model.getFormKey,
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
                                                model.getIsEdit
                                                    ? Expanded(
                                                        child: TextFormField(
                                                          onTapOutside:
                                                              (event) {
                                                            FocusManager
                                                                .instance
                                                                .primaryFocus
                                                                ?.unfocus();
                                                          },
                                                          enabled:
                                                              model.getIsEdit,
                                                          textAlign:
                                                              TextAlign.end,
                                                          style: const TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          validator: model
                                                              .validateEmpty,
                                                          controller: model
                                                              .getNameField,
                                                        ),
                                                      )
                                                    : Text(data.name,
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                              ],
                                            ),
                                            model.getIsEdit
                                                ? Container() // Show nothing when true
                                                : Column(
                                                    children: [
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
                                                          const Text(
                                                            'Email:',
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          ),
                                                          Text(
                                                            data.email,
                                                            style: const TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                            !model.getIsEdit
                                                ? const Divider(
                                                    color: Colors.grey,
                                                    thickness: 1,
                                                    height: 40,
                                                  )
                                                : const SizedBox(
                                                    height: 10,
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
                                                model.getIsEdit
                                                    ? Expanded(
                                                        child: TextFormField(
                                                          onTapOutside:
                                                              (event) {
                                                            FocusManager
                                                                .instance
                                                                .primaryFocus
                                                                ?.unfocus();
                                                          },
                                                          enabled:
                                                              model.getIsEdit,
                                                          textAlign:
                                                              TextAlign.end,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          style: const TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          validator: model
                                                              .validateEmpty,
                                                          controller: model
                                                              .getPhoneField,
                                                        ),
                                                      )
                                                    : Text(data.phone,
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                              ],
                                            ),
                                            !model.getIsEdit
                                                ? const Divider(
                                                    color: Colors.grey,
                                                    thickness: 1,
                                                    height: 40,
                                                  )
                                                : const SizedBox(
                                                    height: 10,
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
                                                model.getIsEdit
                                                    ? Expanded(
                                                        child:
                                                            DropdownButtonFormField2<
                                                                String>(
                                                          isExpanded: true,
                                                          alignment: Alignment
                                                              .centerRight,
                                                          decoration:
                                                              const InputDecoration(
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            16),
                                                          ),
                                                          hint: const Text(
                                                            'Select Your Gender',
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                          ),
                                                          items: model
                                                              .getGenderItems
                                                              .map((item) =>
                                                                  DropdownMenuItem<
                                                                      String>(
                                                                    value: item,
                                                                    child:
                                                                        Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child:
                                                                          Text(
                                                                        item,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                  ))
                                                              .toList(),
                                                          validator: (value) {
                                                            if (value == null) {
                                                              return 'Please select gender.';
                                                            }
                                                            return null;
                                                          },
                                                          onChanged: (value) {
                                                            if (value != null) {
                                                              model
                                                                  .changeGender(
                                                                      value);
                                                            }
                                                          },
                                                          buttonStyleData:
                                                              const ButtonStyleData(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 8),
                                                          ),
                                                          iconStyleData:
                                                              const IconStyleData(
                                                            icon: Icon(
                                                              Icons
                                                                  .arrow_drop_down,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            iconSize: 24,
                                                          ),
                                                          dropdownStyleData:
                                                              DropdownStyleData(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                            ),
                                                          ),
                                                          menuItemStyleData:
                                                              const MenuItemStyleData(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        16),
                                                          ),
                                                          value: model
                                                              .getSelectedGender,
                                                        ),
                                                      )
                                                    : Text(data.gender,
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                              ],
                                            ),
                                            !model.getIsEdit
                                                ? const Divider(
                                                    color: Colors.grey,
                                                    thickness: 1,
                                                    height: 40,
                                                  )
                                                : const SizedBox(
                                                    height: 10,
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
                                                model.getIsEdit
                                                    ? Expanded(
                                                        child: TextFormField(
                                                          onTapOutside:
                                                              (event) {
                                                            FocusManager
                                                                .instance
                                                                .primaryFocus
                                                                ?.unfocus();
                                                          },
                                                          enabled:
                                                              model.getIsEdit,
                                                          textAlign:
                                                              TextAlign.end,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          style: const TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          validator: model
                                                              .validateEmpty,
                                                          controller: model
                                                              .getHeightField,
                                                        ),
                                                      )
                                                    : Text('${data.height}',
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                              ],
                                            ),
                                            !model.getIsEdit
                                                ? const Divider(
                                                    color: Colors.grey,
                                                    thickness: 1,
                                                    height: 40,
                                                  )
                                                : const SizedBox(
                                                    height: 10,
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
                                                model.getIsEdit
                                                    ? Expanded(
                                                        child: TextFormField(
                                                          onTapOutside:
                                                              (event) {
                                                            FocusManager
                                                                .instance
                                                                .primaryFocus
                                                                ?.unfocus();
                                                          },
                                                          enabled:
                                                              model.getIsEdit,
                                                          textAlign:
                                                              TextAlign.end,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          style: const TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          controller: model
                                                              .getWeightField,
                                                          validator: model
                                                              .validateEmpty,
                                                        ),
                                                      )
                                                    : Text('${data.weight}',
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                              ],
                                            ),
                                            !model.getIsEdit
                                                ? const Divider(
                                                    color: Colors.grey,
                                                    thickness: 1,
                                                    height: 40,
                                                  )
                                                : const SizedBox(
                                                    height: 10,
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
                                                model.getIsEdit
                                                    ? Expanded(
                                                        child: TextFormField(
                                                          onTapOutside:
                                                              (event) {
                                                            FocusManager
                                                                .instance
                                                                .primaryFocus
                                                                ?.unfocus();
                                                          },
                                                          enabled:
                                                              model.getIsEdit,
                                                          textAlign:
                                                              TextAlign.end,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          style: const TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          controller:
                                                              model.getAgeField,
                                                          validator: model
                                                              .validateEmpty,
                                                        ),
                                                      )
                                                    : Text('${data.age}',
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                              ],
                                            ),
                                            !model.getIsEdit
                                                ? const Divider(
                                                    color: Colors.grey,
                                                    thickness: 1,
                                                    height: 40,
                                                  )
                                                : const SizedBox(
                                                    height: 10,
                                                  ),
                                            model.getIsEdit
                                                ? Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 15,
                                                            bottom: 35),
                                                    width: 300,
                                                    child: ElevatedButton(
                                                        style: ButtonStyle(
                                                            shape: MaterialStateProperty.all<
                                                                    OutlinedBorder>(
                                                                ContinuousRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20.0)))),
                                                        onPressed: () {
                                                          model
                                                              .saveEditProfile();
                                                        },
                                                        child:
                                                            const Text('Save')),
                                                  )
                                                : InkWell(
                                                    onTapUp: (_) {
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
                                                                      margin: const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                              40),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Center(
                                                                              child: Material(
                                                                                borderRadius: BorderRadius.circular(20),
                                                                                child: InkWell(
                                                                                  borderRadius: BorderRadius.circular(20),
                                                                                  onTapUp: (_) async {
                                                                                    await model.signOut(context);
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
                                                                              child: Material(
                                                                                borderRadius: BorderRadius.circular(20),
                                                                                child: InkWell(
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
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              bottom: 10),
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
                                                                  color: Colors
                                                                      .red,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                            if (!model.getIsEdit)
                                              const Divider(
                                                color: Colors.grey,
                                                thickness: 1,
                                              ),
                                          ],
                                        ),
                                      ))),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
        });
  }
}
