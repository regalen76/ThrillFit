import 'dart:async';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/screens/navigator_view.dart';

class ConnectionViewModel extends BaseViewModel {
  late StreamSubscription<InternetConnectionStatus> listener;

  Future<void> onInit(BuildContext context) async {
    await checkConnection(context);
  }

  void disposeAll() {
    listener.cancel();
  }

  Future<void> checkConnection(BuildContext context) async {
    listener = InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const NavigatorView()));
            break;
          case InternetConnectionStatus.disconnected:
            break;
        }
      },
    );
  }
}
