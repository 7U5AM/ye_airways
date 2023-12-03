import 'dart:async';
import 'package:ye_airways/shared/styles/colors.dart';
import 'package:ye_airways/view/screen/user/login_ye_screen.dart';
import 'package:ye_airways/view/screen/user/signup_ye_screen.dart';
import 'package:ye_airways/view/widgets/custom_button.dart';
import 'package:ye_airways/view/widgets/page_pop_view.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String id = 'OnBoardingScreen';

  const OnBoardingScreen({super.key});

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController(initialPage: 0);
  List<PageViewData> pageViewModelData = [];

  late Timer sliderTimer;
  var currentShowIndex = 0;

  @override
  void initState() {
    pageViewModelData.add(PageViewData(
      titleText: 'Plan your trips',
      subText: 'book one of your unique ticket to\nescape the ordinary',
      assetsImage: 'assets/introduction1.png',
    ));

    pageViewModelData.add(PageViewData(
      titleText: 'Find best deals',
      subText:
          'Find deals for any season from cosy\ncountry homes to city flats',
      assetsImage: 'assets/introduction2.png',
    ));

    pageViewModelData.add(PageViewData(
      titleText: 'Best travelling all time',
      subText:
          'Find deals for any season from cosy\ncountry homes to city flats',
      assetsImage: 'assets/introduction3.png',
    ));

    sliderTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (currentShowIndex == 0) {
        pageController.animateTo(MediaQuery.of(context).size.width,
            duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      } else if (currentShowIndex == 1) {
        pageController.animateTo(MediaQuery.of(context).size.width * 2,
            duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      } else if (currentShowIndex == 2) {
        pageController.animateTo(0,
            duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    sliderTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                pageSnapping: true,
                onPageChanged: (index) {
                  currentShowIndex = index;
                },
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  PagePopup(imageData: pageViewModelData[0]),
                  PagePopup(imageData: pageViewModelData[1]),
                  PagePopup(imageData: pageViewModelData[2]),
                ],
              ),
            ),
            SmoothPageIndicator(
              controller: pageController, // PageController
              count: 3,
              effect: WormEffect(
                  activeDotColor: kPrimaryColor,
                  dotColor: Theme.of(context).dividerColor,
                  dotHeight: 10.0,
                  dotWidth: 10.0,
                  spacing: 5.0), // your preferred effect
              onDotClicked: (index) {},
            ),
            CustomButton(
              margin: const EdgeInsets.only(top: 40, bottom: 10),
              title: "Sign In",
              onPressed: () {
                Navigator.pushNamed(context, LoginYEScreen.id);
              },
            ),
            CustomButton(
              margin: const EdgeInsets.only(top: 10, bottom: 46),
              title: "Sign Up",
              onPressed: () {
                Navigator.pushNamed(context, SignUp_YE_Screen.id);
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }
}
