import 'package:ye_airways/shared/components/constantes.dart';
import 'package:ye_airways/shared/styles/colors.dart';
import 'package:ye_airways/view/screen/main_ye_screen.dart';
import 'package:ye_airways/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class SuccessCheckoutPage extends StatelessWidget {
  const SuccessCheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 150,
              margin: const EdgeInsets.only(bottom: 80),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/image_success.png'))),
            ),
            Text(
              'Well Booked 😍',
              style: blackTextStyle.copyWith(
                fontSize: 32,
                fontWeight: semiBold,
              ),
            ),
            Text(
              'Are you ready to explore the new\n world of experiences?',
              style: greyTextStyle.copyWith(fontSize: 16, fontWeight: light),
              textAlign: TextAlign.center,
            ),
            CustomButton(
              title: 'Home',
              onPressed: () {
                navigateToandFinish(context, Main_YE_Screen());

                // Navigator.pushNamedAndRemoveUntil(
                //     context, Main_YE_Screen.id, (route) => false);
              },
              width: 220,
              margin: const EdgeInsets.only(top: 50),
            )
          ],
        ),
      ),
    );
  }
}
