import 'dart:io';
import 'dart:math';
import 'package:ye_airways/model/hn_user_model.dart';
import 'package:ye_airways/shared/components/constantes.dart';
import 'package:ye_airways/shared/network/local/cache_helper.dart';
import 'package:ye_airways/shared/styles/colors.dart';
import 'package:ye_airways/view/screen/user/bonus_page.dart';
import 'package:ye_airways/view/screen/user/login_ye_screen.dart';
import 'package:ye_airways/view/widgets/custom_button.dart';
import 'package:ye_airways/view/widgets/myalert.dart';
import 'package:path/path.dart' show basename;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignUp_YE_Screen extends StatefulWidget {
  static const String id = 'signup_YE_screen';

  const SignUp_YE_Screen({super.key});
  @override
  State<SignUp_YE_Screen> createState() => _SignUp_YE_ScreenState();
}

class _SignUp_YE_ScreenState extends State<SignUp_YE_Screen> {
  bool isVisable = true;
  File? imgPath;
  String? image;
  var keyForm = GlobalKey<FormState>();

  bool isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  // final locationController = TextEditingController();

  uploadImage2Screen(ImageSource source) async {
    final pickedImg = await ImagePicker().pickImage(source: source);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
          image = basename(pickedImg.path);
          int random = Random().nextInt(9999999);
          image = "$uid$image";
          print(image);
        });
      } else {
        print("NO img selected");
      }
    } catch (e) {
      print("Error => $e");
    }

    if (!mounted) return;
    Navigator.pop(context);
  }

  showmodel() {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(22),
          height: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await uploadImage2Screen(ImageSource.camera);
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.camera,
                      size: 30,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "From Camera",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              GestureDetector(
                onTap: () {
                  uploadImage2Screen(ImageSource.gallery);
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.photo_outlined,
                      size: 30,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "From Gallery",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

/*
  register(HN_UserModel userc) async {
    setState(() {
      isLoading = true;
    });

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      userc.id = credential.user!.uid;
// Upload image to firebase storage
      final storageRef = FirebaseStorage.instance.ref("users-imgs/$image");
      await storageRef.putFile(imgPath!);
      String urll = await storageRef.getDownloadURL();
      userc.imgPath = urll;
      print(credential.user!.uid);
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      users.doc(credential.user!.uid).set(userc.toJson()).then((value) {
        usermodel = userc;
        print("User Added");
        Navigator.pushNamed(context, Main_YE_Screen.id);
      }).catchError((error) => print("Failed to add user: $error"));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, "The account already exists for that email.");
      } else {
        showSnackBar(context, "ERROR - Please try again late");
      }
    } catch (err) {
      showSnackBar(context, err.toString());
    }

    setState(() {
      isLoading = false;
    });
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: keyForm,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 30),
                      child: Text(
                        'Join us and get\nyour next journey',
                        style: blackTextStyle.copyWith(
                            fontSize: 24, fontWeight: semiBold),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(125, 78, 91, 110),
                        ),
                        child: Stack(
                          children: [
                            imgPath == null
                                ? const CircleAvatar(
                                    backgroundColor:
                                        Color.fromARGB(255, 225, 225, 225),
                                    radius: 71,
                                    backgroundImage:
                                        AssetImage("assets/account_user.png"),
                                  )
                                : ClipOval(
                                    child: Image.file(
                                      imgPath!,
                                      width: 145,
                                      height: 145,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error,
                                              stackTrace) =>
                                          const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                    ),
                                  ),
                            Positioned(
                              left: 99,
                              bottom: -10,
                              child: IconButton(
                                onPressed: () {
                                  showmodel();
                                },
                                icon: const Icon(Icons.add_a_photo),
                                color: const Color.fromARGB(255, 94, 115, 128),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        showmodel();
                      },
                    ),
                    const SizedBox(
                      height: 33,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                15,
                              )),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: TextField(
                              controller: usernameController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter Your Name',
                                  suffixIcon:
                                      Icon(Icons.person, color: Colors.grey)),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                15,
                              )),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: TextField(
                              controller: phoneController,
                              keyboardType: TextInputType.number,
                              obscureText: false,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter Your Phone',
                                  suffixIcon: Icon(Icons.phone)),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  15,
                                )),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: TextFormField(
                                validator: (email) {
                                  return email!.contains(RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                                      ? null
                                      : "Enter a valid email";
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                obscureText: false,
                                decoration: const InputDecoration(
                                  hintText: "Enter Your email : ",
                                  suffixIcon: Icon(Icons.email),
                                  border: InputBorder.none,
                                ),
                              ),
                            ))),
                    const SizedBox(
                      height: 22,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  15,
                                )),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: TextFormField(
                                onChanged: (password) {},
                                // we return "null" when something is valid
                                validator: (value) {
                                  return value!.length < 8
                                      ? "Enter at least 8 characters"
                                      : null;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: passwordController,
                                keyboardType: TextInputType.text,
                                obscureText: isVisable ? true : false,
                                decoration: InputDecoration(
                                  hintText: "Enter Your Password : ",
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isVisable = !isVisable;
                                      });
                                    },
                                    icon: isVisable
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off),
                                  ),
                                ),
                              ),
                            ))),
                    // const SizedBox(
                    //   height: 22,
                    // ),
                    // Padding(
                    //     padding: const EdgeInsets.symmetric(
                    //       horizontal: 5,
                    //     ),
                    //     child: Container(
                    //         decoration: BoxDecoration(
                    //             color: Colors.white,
                    //             borderRadius: BorderRadius.circular(
                    //               15,
                    //             )),
                    //         child: Padding(
                    //           padding: const EdgeInsets.symmetric(
                    //             horizontal: 10,
                    //           ),
                    //           child: TextFormField(
                    //             validator: (location) {
                    //               return
                    //                   // location!.contains(RegExp(
                    //                   //     r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                    //                   // ?
                    //                   null;
                    //               //  : "Enter a valid location";
                    //             },
                    //             autovalidateMode:
                    //                 AutovalidateMode.onUserInteraction,
                    //             controller: locationController,
                    //             keyboardType: TextInputType.streetAddress,
                    //             obscureText: false,
                    //             decoration: const InputDecoration(
                    //               hintText: "Enter Your Location : ",
                    //               suffixIcon:
                    //                   const Icon(Icons.location_on_outlined),
                    //               border: InputBorder.none,
                    //             ),
                    //           ),
                    //         ))),

                    const SizedBox(
                      height: 20,
                    ),
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                            title: 'Get Started',
                            onPressed: () async {
                              if (keyForm.currentState!.validate() &&
                                  image != null &&
                                  imgPath != null) {
                                setState(() {
                                  isLoading = true;
                                });

                                FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: emailController.text,
                                        password: passwordController.text)
                                    .then((value) async {
                                  if (value.user != null) {
                                    HN_UserModel usr = HN_UserModel(
                                        email: emailController.text,
                                        userName: usernameController.text,
                                        pass: passwordController.text,
                                        phone: phoneController.text,
                                        id: value.user!.uid,
                                        balance: 200.0);
                                    value.user!.updateDisplayName(
                                        usernameController.text);
                                    // Upload image to firebase storage
                                    final storageRef = FirebaseStorage.instance
                                        .ref("users-imgs/$image");
                                    await storageRef.putFile(imgPath!);
                                    String urll =
                                        await storageRef.getDownloadURL();
                                    usr.imgPath = urll;

                                    FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(value.user!.uid)
                                        .set(usr.toJson())
                                        .then((user1) {
                                      uid = value.user!.uid.toString();
                                      CacheHlper.putData(
                                          key: "uid", value: value.user!.uid);
                                      navigateToandFinish(
                                          context, BonusPage(user: usr));
                                    }).catchError((error) {
                                      MyAlert.errorAlert(context,
                                          desc: "There is an Error!");

                                      setState(() {
                                        isLoading = true;
                                      });

                                      print(error.toString());
                                    });
                                  }
                                }).catchError((error) {
                                  print(error.toString());
                                });
//
                              } else {
                                setState(() {
                                  isLoading = false;
                                });

                                MyAlert.errorAlert(context,
                                    desc: "Please Enter All Data!");
                              }
                            }),
                    const SizedBox(
                      height: 20,
                    ),

                    TextButton(
                      onPressed: () {
                        navigateToandFinish(context, const LoginYEScreen());
                      },
                      child: Text(
                        'You Already have account? Sign In',
                        style: greyTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: light,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
