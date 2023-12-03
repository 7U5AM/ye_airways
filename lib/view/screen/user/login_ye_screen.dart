import 'package:firebase_auth/firebase_auth.dart';
import 'package:ye_airways/shared/components/constantes.dart';
import 'package:ye_airways/shared/network/local/cache_helper.dart';
import 'package:ye_airways/shared/styles/colors.dart';
import 'package:ye_airways/view/screen/main_ye_screen.dart';
import 'package:ye_airways/view/screen/user/signup_ye_screen.dart';
import 'package:ye_airways/view/widgets/custom_button.dart';
import 'package:ye_airways/view/widgets/myalert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginYEScreen extends StatefulWidget {
  static const String id = 'login_YE_screen';

  const LoginYEScreen({super.key});
  @override
  State<LoginYEScreen> createState() => _LoginYEScreenState();
}

class _LoginYEScreenState extends State<LoginYEScreen> {
  var emailController = TextEditingController();
  bool isVisable = true;

  var passwordController = TextEditingController();
  var keyForm = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Form(
              key: keyForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  const SizedBox(
                    height: 250.0,
                    width: 250.0,
                    child: Image(
                      image: AssetImage('assets/logo-ye.png'),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            15,
                          )),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: TextFormField(
                          controller: emailController,
                          validator: ((value) {
                            if (value!.isEmpty) return "Cannot be Empty";

                            return null;
                          }),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              15,
                            )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: TextFormField(
                            controller: passwordController,
                            validator: ((value) {
                              if (value!.isEmpty) return "Cannot be Empty";

                              return null;
                            }),
                            obscureText: isVisable ? true : false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password',
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
                        )),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          title: 'Sign In',
                          onPressed: () async {
                            if (keyForm.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });

                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: emailController.text,
                                      password: passwordController.text)
                                  .then((value) {
                                if (value.user != null) {
                                  uid = value.user!.uid.toString();
                                  CacheHlper.putData(
                                      key: "uid", value: value.user!.uid);
                                  navigateToandFinish(
                                      context, Main_YE_Screen());
                                }
                              }).catchError((error) {
                                MyAlert.errorAlert(context,
                                    desc: "There is an Error!");
                                setState(() {
                                  isLoading = false;
                                });

                                print(error.toString());
                              });
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }),
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Not yet a member? ',
                          style: GoogleFonts.robotoCondensed(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            navigateToandFinish(
                                context, const SignUp_YE_Screen());
                          },
                          child: Text(
                            'Sign up now',
                            style: GoogleFonts.robotoCondensed(
                              color: ksecondaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
