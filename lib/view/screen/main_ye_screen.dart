import 'package:firebase_auth/firebase_auth.dart';
import 'package:ye_airways/shared/components/constantes.dart';
import 'package:ye_airways/shared/network/local/cache_helper.dart';
import 'package:ye_airways/shared/styles/colors.dart';
import 'package:ye_airways/view/screen/admin/add_destination.dart';
import 'package:ye_airways/view/screen/destination/destination_home.dart';
import 'package:ye_airways/view/screen/user/flight_states.dart';
import 'package:ye_airways/view/screen/user/login_ye_screen.dart';
import 'package:ye_airways/view/screen/user/profile_page.dart';
import 'package:ye_airways/view/screen/user/user_tickets.dart';
import 'package:ye_airways/view/widgets/Image_user_from_fire.dart';
import 'package:ye_airways/view/widgets/name_user_from_fire.dart';
import 'package:ye_airways/view/widgets/user_email_from_fire.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class Main_YE_Screen extends StatelessWidget {
  static const String id = 'Main_YE_Screen';

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  Main_YE_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    User? user2 = FirebaseAuth.instance.currentUser;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('YEMENIA AIRWAYS'),
        centerTitle: true,
        leading: IconButton(
          iconSize: 30,
          onPressed: (() {
            scaffoldKey.currentState!.openDrawer();
          }),
          icon: const Icon(Icons.menu),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 280,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: const ImgUser(),
                    ),
                    const SizedBox(height: 10.0),
                    const Center(child: UserName()),
                    const SizedBox(height: 10.0),
                    const Center(child: EmailUser()),
                    const SizedBox(height: 5.0),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.person,
                color: kPrimaryColor,
              ),
              title: const Text(
                'Profile',
                style: TextStyle(fontSize: 18, color: kPrimaryColor),
              ),
              onTap: () {
                Navigator.pushNamed(context, Profile_YE_Screen.id);
              },
            ),
            ListTile(
                title: const Text(
                  "My Tickets",
                  style: TextStyle(fontSize: 18, color: kPrimaryColor),
                ),
                leading: const Icon(
                  Icons.airplane_ticket_outlined,
                  color: kPrimaryColor,
                ),
                onTap: () {
                  Navigator.pushNamed(context, UserTickets.id);
                }),

            // ListTile(
            //   leading: Icon(
            //     Icons.settings,
            //     color: kPrimaryColor,
            //   ),
            //   title: Text(
            //     'Settings',
            //     style: TextStyle(fontSize: 18, color: kPrimaryColor),
            //   ),
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            // ),
            user2!.email == '7usam.pro@gmail.com'
                ? ListTile(
                    title: const Text(
                      "Add Destination",
                      style: TextStyle(fontSize: 18, color: kPrimaryColor),
                    ),
                    leading: const Icon(
                      Icons.add_home_work_outlined,
                      color: kPrimaryColor,
                    ),
                    onTap: () {
                      navigateTo(context, const AddDestinationPage());
                      // Navigator.pushNamed(context, AddDestinationPage.id);
                    })
                : Container(),

            user2.email == '7usam.pro@gmail.com'
                ? ListTile(
                    title: const Text(
                      "Flight States",
                      style: TextStyle(fontSize: 18, color: kPrimaryColor),
                    ),
                    leading: const Icon(
                      Icons.check_box_outlined,
                      color: kPrimaryColor,
                    ),
                    onTap: () {
                      navigateTo(context, const Flight_States());

                      // Navigator.pushNamed(context, GetStartedPage.id);
                    })
                : Container(),
            ListTile(
              leading: const Icon(
                Icons.arrow_back,
                color: kPrimaryColor,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(fontSize: 18, color: kPrimaryColor),
              ),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                CacheHlper.removeData(key: "uid");

                navigateToandFinish(context, const LoginYEScreen());
              },
            ),
          ],
        ),
      ),
      body: const Destination_Home(),
    );
  }
}
