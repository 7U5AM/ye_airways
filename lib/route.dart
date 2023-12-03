import 'package:flutter/material.dart';
import 'package:ye_airways/view/screen/admin/add_destination.dart';
import 'package:ye_airways/view/screen/destination/des_details_page.dart';
import 'package:ye_airways/view/screen/destination/destination_home.dart';
import 'package:ye_airways/view/screen/main_ye_screen.dart';
import 'package:ye_airways/view/screen/splash/get_started.dart';
import 'package:ye_airways/view/screen/splash/introductionScreen.dart';
import 'package:ye_airways/view/screen/splash/splash_page.dart';
import 'package:ye_airways/view/screen/user/login_ye_screen.dart';
import 'package:ye_airways/view/screen/user/profile_page.dart';
import 'package:ye_airways/view/screen/user/signup_ye_screen.dart';
import 'package:ye_airways/view/screen/user/user_tickets.dart';

Map<String, Widget Function(BuildContext)> routes = {
  SplashHome.id: (context) => const SplashHome(),
  GetStartedPage.id: (context) => const GetStartedPage(),
  OnBoardingScreen.id: (context) => const OnBoardingScreen(),
  LoginYEScreen.id: (context) => const LoginYEScreen(),
  SignUp_YE_Screen.id: (context) => const SignUp_YE_Screen(),
  Main_YE_Screen.id: (context) => Main_YE_Screen(),
  Profile_YE_Screen.id: (context) => const Profile_YE_Screen(),
  Destination_Home.id: (context) => const Destination_Home(),
  DesDetailPage.id: (context) => const DesDetailPage(),
  AddDestinationPage.id: (context) => const AddDestinationPage(),
  UserTickets.id: (context) => const UserTickets(),
};
