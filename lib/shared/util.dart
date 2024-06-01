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
          height: 160,
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: Colors.blue, width: 2.0),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.blue,
                  width: 2.0), // Border for the inner container
              borderRadius: BorderRadius.circular(
                  15.0), // Rounded corners for the inner container
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      const Text(
                        'INFO',
                        style: TextStyle(fontSize: 22, color: Colors.blue),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: Icon(
                          MdiIcons.informationOutline,
                          color: Colors.blue,
                          size: 35,
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.blue,
                  thickness: 2,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    message,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
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
          height: 160,
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.red,
                  width: 2.0), // Border for the inner container
              borderRadius: BorderRadius.circular(
                  15.0), // Rounded corners for the inner container
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      const Text(
                        'ERROR',
                        style: TextStyle(fontSize: 22, color: Colors.red),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: Icon(
                          MdiIcons.alertCircleOutline,
                          color: Colors.red,
                          size: 35,
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.red,
                  thickness: 2,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    message,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
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
