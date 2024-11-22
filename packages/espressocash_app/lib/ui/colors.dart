import 'package:flutter/material.dart';

abstract class CpColors {
  const CpColors._();

  // Color style
  static const primaryColor = Color(0xffff6640);
  static const yellowColor = Color(0xffFCC829);
  static const greenColor = Color(0xff8AE4BF);
  static const sandColor = Color(0xFFA89767);
  static const lightSandColor = Color(0xFFB7A572);
  static const darkSandColor = Color(0xFF9E8B5A);
  static const alertRedColor = Color(0xffe8452f);
  static const greyColor = Color(0xff999999);
  static const deepGreyColor = Color(0xFF2D2B2C);
  static const blackGreyColor = Color(0xff181818);

  // Status colors
  static const successBackgroundColor = Color(0xFF62D58F);
  static const errorBackgroundColor = Color(0xffff6640);
  static const infoBackgroundColor = Color(0xFFF6C83B);
  static const neutralBackgroundColor = Color(0xff5F6464);

  static const primaryTextColor = Color(0xff231f20); // black primary color
  static const secondaryTextColor = Color(0xff909090);
  static const placeholderLightColor = Color(0xffC2C2C2);
  static const listDividerColor = Color(0xffF5F5F5);
  static const homeDividerColor = Color(0xff3f3c3d);

  static const dangerButtonTextColor = Color(0xffEA4C37);
  static const dangerButtonBackground = Color(0xFF793C22);

  // button state colors
  static const translucentYellowColor = Color(0x30e7b11f);
  static const lightButtonBackgroundColor = Color(0xffffffff);
  static const lightGreyBackground = Color(0xffF5F5F5);
  static const backgroundAccentColor = Color(0xffff9551);
  static const greyIconBackgroundColor = Color(0xfff0efe7);

  static const darkDividerColor = Color(0xff454243);
  static const sliderDisabledColor = Color(0xff323232);

  static const blackTextFieldBackgroundColor = Color(0xff404040);

  static const darkOrangeBackgroundColor = Color(0xFFD86322);
  static const goldBackgroundColor = Color(0xFFC8B57D);
}

const bgGradient = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.centerLeft,
  colors: [Color(0xfff45440), Color(0xffff8b49)],
  stops: [0.1, 1.0],
);
