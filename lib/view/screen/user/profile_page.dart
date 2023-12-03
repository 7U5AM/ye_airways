import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ye_airways/shared/components/constantes.dart';
import 'package:ye_airways/shared/network/local/cache_helper.dart';
import 'package:ye_airways/shared/styles/colors.dart';
import 'package:ye_airways/view/screen/user/login_ye_screen.dart';
import 'package:ye_airways/view/widgets/Image_user_from_fire.dart';
import 'package:ye_airways/view/widgets/data_from_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show basename;

class Profile_YE_Screen extends StatefulWidget {
  static const String id = 'profile_YE_screen';

  const Profile_YE_Screen({super.key});

  @override
  State<Profile_YE_Screen> createState() => _Profile_YE_ScreenState();
}

class _Profile_YE_ScreenState extends State<Profile_YE_Screen> {
  final credential = FirebaseAuth.instance.currentUser;
  File? imgPath;
  String? imgName;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  get kprimaryColor => null;

  uploadImage2Screen() async {
    final pickedImg =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
          imgName = basename(pickedImg.path);
          int random = Random().nextInt(9999999);
          imgName = "$random$imgName";
        });
      } else {
        print("NO img selected");
      }
    } catch (e) {
      print("Error => $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    const ImgUser();
  }

  bool Function(Route<dynamic>)? predicate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.deepPurple,
        backgroundColor: kPrimaryColor,
        actions: [
          TextButton.icon(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              CacheHlper.removeData(key: "uid");
              print("User = ${uid != "" ? uid : Null} =-=-=-=-=-=-=-=-=-=-");

              navigateToandFinish(context, const LoginYEScreen());

              // Navigator.pushNamedAndRemoveUntil(context,
              //     MaterialPageRoute(builder: (BuildContext context) {
              //   return LoginYEScreen.id;
              // }), (r) {
              //   return false;
              // });
            },
            label: const Text(
              "logout",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
        title: const Text("Profile Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(124, 255, 255, 255),
                  ),
                  child: Stack(
                    children: [
                      imgPath == null
                          ? const ImgUser()
                          : ClipOval(
                              child: Image.file(
                                imgPath!,
                                width: 145,
                                height: 145,
                                fit: BoxFit.cover,
                              ),
                            ),
                      Positioned(
                        left: 103,
                        bottom: -10,
                        child: IconButton(
                          onPressed: () async {
                            await uploadImage2Screen();

                            if (imgPath != null) {
                              // Upload image to firebase storage
                              final storageRef = FirebaseStorage.instance
                                  .ref("users-imgs/$imgName");
                              await storageRef.putFile(imgPath!);
                              // Get img url
                              String urlll = await storageRef.getDownloadURL();

                              users.doc(credential!.uid).update({
                                "imgPath": urlll,
                              });
                            }
                          },
                          icon: const Icon(Icons.add_a_photo),
                          color: const Color.fromARGB(255, 94, 115, 128),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 33,
              ),
              const SizedBox(
                height: 22,
              ),
              Center(
                  child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          color: kprimaryColor,
                          borderRadius: BorderRadius.circular(11)),
                      child: Text(
                        "User Data",
                        style: GoogleFonts.robotoCondensed(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ))),
              GetDataFromFirestore(
                documentId: credential!.uid,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
