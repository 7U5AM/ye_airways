import 'package:ye_airways/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MyAlert {
  static Future<bool?> errorAlert(BuildContext context, {String? desc}) {
    return Alert(
        context: context,
        style: const AlertStyle(
          descStyle: TextStyle(color: kPrimaryColor),
          // backgroundColor: kPrimaryColor,
          titleStyle: TextStyle(
            color: Colors.red,
          ),
        ),
        type: AlertType.error,
        title: "ERROR!",
        desc: desc,
        buttons: [
          DialogButton(
            color: kPrimaryColor,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "CANCEL",
              style: TextStyle(
                color: kWhiteColor,
                fontSize: 20,
              ),
            ),
          )
        ]).show();
  }

  static Alert noSeatsAlert(BuildContext context, {String? bookingClass}) {
    return Alert(
        context: context,
        style: const AlertStyle(
          descStyle: TextStyle(color: Colors.white),
          backgroundColor: kPrimaryColor,
          titleStyle: TextStyle(
            color: kAccentColor,
          ),
        ),
        type: AlertType.error,
        title: "ERROR!",
        desc: "There is no any seat available in $bookingClass class",
        buttons: [
          DialogButton(
            color: kAccentColor,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "CANCEL",
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 20,
              ),
            ),
          )
        ]);
  }
}
