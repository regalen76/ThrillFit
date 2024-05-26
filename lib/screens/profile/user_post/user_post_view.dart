import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/screens/profile/user_post/user_post_view_model.dart';

class UserPostView extends StatelessWidget {
  const UserPostView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => UserPostViewModel(),
        builder: (context, model, _) {
          return model.isBusy
              ? const Center(child: CircularProgressIndicator())
              : const Center(
                  child: Text('user posts'),
                );
        });
  }
}
