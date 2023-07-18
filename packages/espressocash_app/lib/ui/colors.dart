import 'package:flutter/material.dart';

abstract class CpColors {
  const CpColors._();

  static const primaryColor = Color(0xffff6640); // red primary color

  static const strokeColor = Color(0xffff8956); // stroke color

  static const yellowColor = Color(0xffF6C83B); // yellow primary color
  static const translucentYellowColor = Color(0x30e7b11f);

  static const primaryTextColor = Color(0xff231f20); // black primary color
  static const secondaryTextColor = Color(0xff909090);
  static const disabledTabColor = Color(0xffbababa);
  static const placeholderLightColor = Color(0xffC2C2C2);
  static const listDividerColor = Color(0xffF5F5F5);

  static const lightGreyBackground = Color(0xffF5F5F5); // for menu buttons

  static const lightButtonBackgroundColor = Color(0xffffffff);

  static const lightTextFieldBackgroundColor = Color(0xfff0f0f0);

  static const purple = Color(0xffA695FF);

  static const darkBackground = Color(0xff2d2b2b);
  static const shadowPrimaryColor = Color(0xffeb5f3a);
  static const accentDarkBackground = Color(0xff2c2d31);
  static const darkPrimaryColor = Color(0xffd74924);

  static const backgroundAccentColor = Color(0xffff9551);
  static const greyBackground = Color(0xfff4f4f4);
  static const menuPrimaryTextColor = Color(0xff34393c);
  static const greyIconBackgroundColor = Color(0xfff0efe7);

  static const primaryAccentColor = Color(0xfffce4da);
  static const yellowDarkAccentColor = Color(0xfffcc829);
  static const greyDarkAccentColor = Color(0xff9d9d9d);
  static const greenDropdownEnabled = Color(0xff4db43d);
  static const greenDropdownDisabled = Color(0xff2f6b25);

  static const successBackgroundColor = Color(0xff62d58f);
  static const errorBackgroundColor = Color(0xffff6640);
  static const infoBackgroundColor = Color(0xfff2bd1a);
  static const neutralBackgroundColor = Color(0xffB5B5B5);
  static const disabledColor = Color(0xffbbbbbb);
  static const accentDisabledColor = Color(0xffff8666);
  static const errorChipColor = Color(0xffe8452f);

  static const lightPillBackgroundColor = Color(0xffeaeaea);

  static const chartLineColor = Color(0xfff9653e);
  static const lightBackgroundColor = Color(0xff464646);
  static const darkBackgroundColor = Color(0xff181818);
  static const darkDividerColor = Color(0xff4b4b4b);

  static const sliderDisabledColor = Color(0xff323232);

  static const incomingAmountColor = Color(0xff24BE20);

  static const darkSplashBackgroundColor = Color(0xff2D2B2C);
}

const bgGradient = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.centerLeft,
  colors: [Color(0xfff45440), Color(0xffff8b49)],
  stops: [0.1, 1.0],
);
