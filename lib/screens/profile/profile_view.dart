import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
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
              : Scaffold(
                  appBar: AppBar(
                    title: const Text('Profile'),
                  ),
                  body: Container(
                    height: double.infinity,
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.30,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                  radius: 80,
                                  backgroundImage: NetworkImage(model
                                      .getProfilePictureUrl) // Replace 'assets/avatar.png' with your image path
                                  ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    // Add your edit button functionality here
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.10,
                          color: Colors.pink,
                          child: const Row(
                            children: [Text('1'), Text('2'), Text('3')],
                          ),
                        ),
                        Expanded(
                            child: Container(
                          margin: const EdgeInsets.only(top: 15),
                          child: const Column(
                            children: [
                              Text('1'),
                              Divider(
                                color: Colors.black,
                                thickness: 1,
                                height: 1,
                              ),
                              Text('2'),
                              Divider(
                                color: Colors.black,
                                thickness: 1,
                                height: 1,
                              ),
                              Text('3')
                            ],
                          ),
                        )),
                        Text(model.getUser?.email ?? 'Not Signed In'),
                        ElevatedButton(
                            onPressed: () {
                              model.signOut();
                              Navigator.pop(context);
                            },
                            child: const Text('Sign Out')),
                      ],
                    ),
                  ),
                );
        });
  }
}
