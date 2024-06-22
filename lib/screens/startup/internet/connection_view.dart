import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/screens/startup/internet/connection_view_model.dart';

class ConnectionView extends StatelessWidget {
  const ConnectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => ConnectionViewModel(),
        onViewModelReady: (model) => model.onInit(context),
        onDispose: (model) => model.disposeAll(),
        builder: (context, model, _) {
          return model.isBusy
              ? const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                )
              : const Scaffold(
                  body: Center(
                    child: Text('This App Requires An Connection'),
                  ),
                );
        });
  }
}
