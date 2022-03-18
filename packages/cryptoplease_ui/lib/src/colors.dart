import 'package:flutter/material.dart';

abstract class CpColors {
  CpColors._();

  static const primaryColor = Color(0xfff46640); // red primary color

  static const strokeColor = Color(0xffff8956); // stroke color

  static const yellowColor = Color(0xfffacf48); // yellow primary color
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
}

const bgGradient = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.centerLeft,
  colors: [Color(0xfff45440), Color(0xffff8b49)],
  stops: [0.1, 1.0],
);
