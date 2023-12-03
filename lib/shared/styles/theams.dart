import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ye_airways/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
    fontFamily: "Cairo",
    primaryColor: mainColor,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: bckColor,
    appBarTheme: const AppBarTheme(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: bckColor,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarBrightness: Brightness.light),
        titleSpacing: 20,
        elevation: 0,
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: mainColor),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        elevation: 20,
        selectedItemColor: mainColor,
        unselectedItemColor: Colors.grey),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(
          color: Colors.grey, fontSize: 14, fontWeight: FontWeight.normal),
    ));

ThemeData darkTheme = ThemeData(
    fontFamily: "Cairo",
    primaryColor: Colors.pink,
    primarySwatch: Colors.pink,
    scaffoldBackgroundColor: Colors.black54,
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black54,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white, statusBarBrightness: Brightness.dark),
        titleSpacing: 20,
        elevation: 0,
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: Colors.pink),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
        elevation: 20,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey),
    textTheme: TextTheme(
      bodyLarge: const TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(
          color: Colors.grey.shade100,
          fontSize: 14,
          fontWeight: FontWeight.normal),
    ));
