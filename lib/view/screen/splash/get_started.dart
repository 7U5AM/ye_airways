import 'package:ye_airways/shared/styles/colors.dart';
import 'package:ye_airways/view/screen/splash/introductionScreen.dart';
import 'package:ye_airways/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class GetStartedPage extends StatelessWidget {
  static const String id = 'GetStartedPage';

  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/image_get_started.png'))),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Fly Like a Bird',
                  style: whiteTextStyle.copyWith(
                      fontSize: 32, fontWeight: semiBold),
                ),
                const SizedBox(
                  height: 10,
                ),

                Text(
                  'Explore new world with us and let\nyourself get an amazing experiences',
                  style:
                      whiteTextStyle.copyWith(fontSize: 16, fontWeight: light),
                  textAlign: TextAlign.center,
                ),
                // Text(
                //   "The National Carrier of Yemen",
                //   style: whiteTextStyle.copyWith(
                //       fontSize: 25, fontWeight: semiBold),
                // ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: CustomButton(
                      title: 'Get Started',
                      // width: 220,
                      margin: const EdgeInsets.only(top: 50, bottom: 80),
                      onPressed: () {
                        Navigator.pushNamed(context, OnBoardingScreen.id);
                        // Navigator.pushNamed(context, SignUp_YE_Screen.id);
                      }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
