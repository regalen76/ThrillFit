import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/screens/profile/profile_create/profile_create_model.dart';

class ProfileCreateView extends StatelessWidget {
  const ProfileCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => ProfileCreateModel(),
        onViewModelReady: (viewModel) {
          viewModel.initState();
        },
        onDispose: (viewModel) => {viewModel.disposeAll()},
        builder: (context, model, _) {
          return model.isBusy
              ? const Center(child: CircularProgressIndicator())
              : Scaffold(
                  appBar: AppBar(
                    title: const Text('Profile'),
                  ),
                  body: SingleChildScrollView(
                    child: SizedBox(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.30,
                            width: MediaQuery.of(context).size.width,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                model.getProfilePath.isEmpty
                                    ? const CircleAvatar(
                                        radius: (82),
                                        backgroundColor: Colors.transparent,
                                        child: CircularProgressIndicator(),
                                      )
                                    : CircleAvatar(
                                        radius: (82),
                                        backgroundColor: Colors.transparent,
                                        backgroundImage:
                                            NetworkImage(model.getProfilePath),
                                      ),
                                Positioned(
                                  top: 10,
                                  right: 80,
                                  child: IconButton(
                                    icon: Icon(
                                      MdiIcons.imageEdit,
                                      size: 35,
                                    ),
                                    onPressed: () {
                                      model.changeProfilePicture();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                              child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Form(
                                    key: model.getFormKey,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Name:',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                )),
                                            Expanded(
                                              child: TextFormField(
                                                onTapOutside: (event) {
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                },
                                                textAlign: TextAlign.end,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                validator: model.validateEmpty,
                                                controller: model.getNameField,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Phone:',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                )),
                                            Expanded(
                                              child: TextFormField(
                                                onTapOutside: (event) {
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                },
                                                textAlign: TextAlign.end,
                                                keyboardType:
                                                    TextInputType.number,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                validator: model.validateEmpty,
                                                controller: model.getPhoneField,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Gender:',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                )),
                                            Expanded(
                                              child: DropdownButtonFormField2<
                                                  String>(
                                                isExpanded: true,
                                                alignment:
                                                    Alignment.centerRight,
                                                decoration:
                                                    const InputDecoration(
                                                  // Add Horizontal padding using menuItemStyleData.padding so it matches
                                                  // the menu padding when button's width is not specified.
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 16),
                                                  // Add more decoration..
                                                ),
                                                hint: const Text(
                                                  'Select Your Gender',
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                                items: model.getGenderItems
                                                    .map((item) =>
                                                        DropdownMenuItem<
                                                            String>(
                                                          value: item,
                                                          child: Container(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Text(
                                                              item,
                                                              style: const TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
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
                                                    model.changeGender(value);
                                                  }
                                                },
                                                buttonStyleData:
                                                    const ButtonStyleData(
                                                  padding:
                                                      EdgeInsets.only(right: 8),
                                                ),
                                                iconStyleData:
                                                    const IconStyleData(
                                                  icon: Icon(
                                                    Icons.arrow_drop_down,
                                                    color: Colors.white,
                                                  ),
                                                  iconSize: 24,
                                                ),
                                                dropdownStyleData:
                                                    DropdownStyleData(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                ),
                                                menuItemStyleData:
                                                    const MenuItemStyleData(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Height:',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                )),
                                            Expanded(
                                              child: TextFormField(
                                                onTapOutside: (event) {
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                },
                                                textAlign: TextAlign.end,
                                                keyboardType:
                                                    TextInputType.number,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                validator: model.validateEmpty,
                                                controller:
                                                    model.getHeightField,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Weight:',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                )),
                                            Expanded(
                                              child: TextFormField(
                                                onTapOutside: (event) {
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                },
                                                textAlign: TextAlign.end,
                                                keyboardType:
                                                    TextInputType.number,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                controller:
                                                    model.getWeightField,
                                                validator: model.validateEmpty,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Age:',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                )),
                                            Expanded(
                                              child: TextFormField(
                                                onTapOutside: (event) {
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                },
                                                textAlign: TextAlign.end,
                                                keyboardType:
                                                    TextInputType.number,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                controller: model.getAgeField,
                                                validator: model.validateEmpty,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 15, bottom: 35),
                                          width: 300,
                                          child: ElevatedButton(
                                              style: ButtonStyle(
                                                  shape: MaterialStateProperty.all<
                                                          OutlinedBorder>(
                                                      ContinuousRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0)))),
                                              onPressed: () {
                                                model
                                                    .saveCreateProfile(context);
                                              },
                                              child: const Text('Save')),
                                        ),
                                      ],
                                    ),
                                  ))),
                        ],
                      ),
                    ),
                  ));
        });
  }
}
