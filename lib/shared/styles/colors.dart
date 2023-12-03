import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Main theme colors
const kPrimaryColor = Color.fromARGB(255, 1, 13, 100);
const kAccentColor = Color(0xFFFFCDA3);

//Color for horizontal and vertical lines.
const kLinesColor = Color(0xFFA4BDBC); //A1BAB8

//Colors for Primary Color Background Container for Myflight Screen
const kActiveTextColor = Color(0xFFA3BEBC);
const kInactiveTextColor = Color(0xFF78909c);

//Login Button Text Color
const kLoginTextColor = Color(0xFF495A52);

//Color for the Container behind the picture.
const kUpperContainerColor = Color(0xFFcfd8dc); //it's look good.

//Colors for White Background Container for flight Screen
const Color kActiveColor = Color(0xFF435C59);
// const Color kInactiveColor = Color(0xFFA3A9A9);
const Color kDateTimeAndCitesColor = Color(0xFF738483);

//white theme color for background.
const Color kWhiteColor = Color(0xFFFFFFFF);

///////////////////////////////////////////////////////
const Color bckColor = Color.fromRGBO(245, 247, 251, 1);
const Color mainColor = Color(0xFF64befd);
const Color secondColor = Color(0xFF78d9fd);

// *************** hn flight colors *************

double defaultMargin = 24.0;
// double defaultRadius =

// Color kPrimaryColor = Color.fromARGB(255, 16, 0, 78);
Color kBlackColor = const Color(0xff1F1449);
Color kGreyColor = const Color(0xff9698A9);
Color kGreenColor = const Color(0xff0EC3AE);
Color kRedColor = const Color(0xffEB70A5);
Color kBackgroundColor = const Color(0xffFAFAFA);
Color kInactiveColor = const Color(0xffDBD7EC);
Color kTransparentColor = Colors.transparent;
Color kAvailableColor = const Color(0xffE0D9FF);
Color kUnavailableColor = const Color(0xffEBECF1);

Color get primaryTextColor => const Color(0xFF262626);
Color get secondaryTextColor => const Color(0xFFADADAD);

TextStyle blackTextStyle = GoogleFonts.poppins(
  color: kPrimaryColor,
);

TextStyle whiteTextStyle = GoogleFonts.poppins(
  color: kWhiteColor,
);

TextStyle greyTextStyle = GoogleFonts.poppins(
  color: kGreyColor,
);

TextStyle greenTextStyle = GoogleFonts.poppins(
  color: kGreenColor,
);

TextStyle redTextStyle = GoogleFonts.poppins(
  color: kRedColor,
);

TextStyle purpleTextStyle = GoogleFonts.poppins(
  color: kPrimaryColor,
);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;
FontWeight black = FontWeight.w900;
