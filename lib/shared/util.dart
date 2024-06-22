import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Util {
  ScaffoldMessengerState flashMessageInfo(
      BuildContext context, String message) {
    return ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          height: 120,
          decoration: BoxDecoration(
            color: const Color(0XFF151515),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  15.0), // Rounded corners for the inner container
            ),
            child: Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 20, right: 10),
                    child: Icon(
                      MdiIcons.information,
                      color: Colors.blue,
                      size: 52,
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20, right: 20),
                  color: Colors.blue,
                  width: 5,
                ),
                Column(
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
                )
              ],
            ),
          ),
        ),
        behavior: SnackBarBehavior
            .floating, // Optional: Makes the SnackBar float above the bottom of the screen
      ));
  }

  ScaffoldMessengerState flashMessageError(
      BuildContext context, String message) {
    return ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          height: 120,
          decoration: BoxDecoration(
            color: const Color(0XFF151515),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  15.0), // Rounded corners for the inner container
            ),
            child: Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 20, right: 10),
                    child: Icon(
                      MdiIcons.alphaXCircle,
                      color: Colors.red,
                      size: 52,
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20, right: 20),
                  color: Colors.red,
                  width: 5,
                ),
                Column(
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
                            color: Colors.red),
                      ),
                    ),
                    Text(
                      message,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        behavior: SnackBarBehavior
            .floating, // Optional: Makes the SnackBar float above the bottom of the screen
      ));
  }

  ScaffoldMessengerState flashMessageSuccess(
      BuildContext context, String message) {
    return ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          height: 120,
          decoration: BoxDecoration(
            color: const Color(0XFF151515),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  15.0), // Rounded corners for the inner container
            ),
            child: Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 20, right: 10),
                    child: Icon(
                      MdiIcons.checkCircle,
                      color: Colors.green,
                      size: 52,
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20, right: 20),
                  color: Colors.green,
                  width: 5,
                ),
                Column(
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
                            color: Colors.green),
                      ),
                    ),
                    Text(
                      message,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        behavior: SnackBarBehavior
            .floating, // Optional: Makes the SnackBar float above the bottom of the screen
      ));
  }
}
