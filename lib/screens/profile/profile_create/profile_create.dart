import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/screens/profile/profile_create/profile_create_model.dart';

class ProfileCreateView extends StatelessWidget {
  const ProfileCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => ProfileCreateModel(),
        builder: (context, model, _) {
          return model.isBusy
              ? const Center(child: CircularProgressIndicator())
              : Scaffold(
                  appBar: AppBar(
                    title: const Text('Profile'),
                  ),
                  body: Container());
        });
  }
}
