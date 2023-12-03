// import 'package:flutter/cupertino.dart';
// import 'package:ye_airways/model/model_hn/user.dart';
import 'package:ye_airways/model/hn_user_model.dart';
import 'package:flutter/material.dart';

String keyIsDark = "isdark";
String keyToken = "token";
String token = "";

String uid = "";
// UserModle? userModel;
navigateTo(context, widget) {
  Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
      ));
}

navigateToandFinish(context, widget) {
  Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
      ));
}

const kbackgroundColor = Color(0xFFF1EFF1);
// final kprimaryColor = Color(0xFF7D2BE1);
const ksecondaryColor = Color(0xFFfcca46);
const ktextColor = Color(0xFF023047);
const ktextlightColor = Color(0xFF747474);
const kblackColor = Color(0xFF58CFE8);
HN_UserModel? usermodel;
