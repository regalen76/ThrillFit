import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:neopop/widgets/buttons/neopop_tilted_button/neopop_tilted_button.dart';
import 'package:thrill_fit/screens/playground/test_data_page.dart';
import 'package:thrill_fit/services/auth.dart';
import 'package:thrill_fit/repository/tester_repo.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PlaygroundPage extends StatefulWidget {
  const PlaygroundPage({super.key});

  @override
  State<PlaygroundPage> createState() => _PlaygroundPageState();
}

class _PlaygroundPageState extends State<PlaygroundPage> {
  bool isLoading = true;

  final User? user = Auth().currentUser;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  Future<void> loadImage() async {
    var storageRef =
        FirebaseStorage.instance.ref().child('profile-image/${user!.uid}.png');
    print(storageRef.fullPath);
    var temp = await storageRef.getDownloadURL();
    setState(() {
      imageUrl = temp;
      isLoading = false;
    });
  }

  File? _imgFile;

  void takeSnapshot() async {
    final ImagePicker picker = ImagePicker();
    final XFile? img = await picker.pickImage(
        source: ImageSource.gallery // alternatively, use ImageSource.gallery
        );
    if (img == null) return;

    final theRef =
        FirebaseStorage.instance.ref().child('profile-image/${user!.uid}.png');

    UploadTask uploadTask = theRef.putFile(File(img.path));

    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          final progress =
              100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          print("Upload is $progress% complete.");
          break;
        case TaskState.paused:
          print("Upload is paused.");
          break;
        case TaskState.canceled:
          print("Upload was canceled");
          break;
        case TaskState.error:
          // Handle unsuccessful uploads
          break;
        case TaskState.success:
          // Handle successful uploads on complete
          print("Success");
          checkDownloadUrl(theRef);
          // ...
          break;
      }
    });
  }

  void checkDownloadUrl(Reference theRef) async {
    print(theRef.fullPath);
    var temp = await theRef.getDownloadURL();
    print(temp);
    setState(() {
      imageUrl = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Playground'),
      ),
      // body:
      // isLoading
      //     ? Center(child: Text('wait'))
      //     :
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Playground"),
            NeoPopTiltedButton(
              color: Colors.white60,
              onTapUp: () {
                final snackBar = SnackBar(
                  /// need to set following properties for best effect of awesome_snackbar_content
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'Error',
                    message:
                        'This is an example error message that will be shown in the body of snackbar!',

                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                    contentType: ContentType.failure,
                  ),
                );

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 80.0,
                  vertical: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Test snackbar",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            NeoPopTiltedButton(
              color: Colors.white60,
              onTapUp: () async {
                await TesterRepo(uid: user!.uid)
                    .createTesterData("hello test", 4);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 80.0,
                  vertical: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Test add data",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            NeoPopTiltedButton(
              color: Colors.white60,
              onTapUp: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => TestDataPage()));
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 80.0,
                  vertical: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Test view list added data",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            NeoPopTiltedButton(
              color: Colors.white60,
              onTapUp: () {
                takeSnapshot();
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 80.0,
                  vertical: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Upload image",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            isLoading
                ? const Center(child: Text('No Image'))
                : Image.network(imageUrl!)
            // Image.network(imageUrl!)
          ],
        ),
      ),
    );
  }
}
