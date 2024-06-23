import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Util {
  ScaffoldMessengerState flashMessageInfo(
      BuildContext context, String message) {
    return ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        showCloseIcon: true,
        backgroundColor: const Color(0XFF151515),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        content: Row(
          children: [
            Container(
                margin: const EdgeInsets.only(right: 20),
                child: Icon(
                  MdiIcons.information,
                  color: Colors.blue,
                  size: 40,
                )),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: const Text(
                      'Info',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 104, 187, 255)),
                    ),
                  ),
                  Text(
                    message,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  )
                ],
              ),
            )
          ],
        ),
        behavior: SnackBarBehavior.floating,
      ));
  }

  ScaffoldMessengerState flashMessageError(
      BuildContext context, String message) {
    return ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        showCloseIcon: true,
        backgroundColor: const Color(0XFF151515),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        content: Row(
          children: [
            Container(
                margin: const EdgeInsets.only(right: 20),
                child: Icon(
                  MdiIcons.alphaXCircle,
                  color: Colors.red,
                  size: 40,
                )),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: const Text(
                      'Error Info',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),
                  Text(
                    message,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  )
                ],
              ),
            )
          ],
        ),
        behavior: SnackBarBehavior.floating,
      ));
  }

  ScaffoldMessengerState flashMessageSuccess(
      BuildContext context, String message) {
    return ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        showCloseIcon: true,
        backgroundColor: const Color(0XFF151515),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        content: Row(
          children: [
            Container(
                margin: const EdgeInsets.only(right: 20),
                child: Icon(
                  MdiIcons.checkCircle,
                  color: Colors.green,
                  size: 40,
                )),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: const Text(
                      'Success Info',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ),
                  Text(
                    message,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  )
                ],
              ),
            )
          ],
        ),
        behavior: SnackBarBehavior.floating,
      ));
  }
}
