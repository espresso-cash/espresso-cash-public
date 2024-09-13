import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class CpUserAvatar extends StatelessWidget {
  const CpUserAvatar({
    super.key,
    required this.userName,
    this.image,
    this.radius = 24,
  });

  final String userName;
  final double radius;
  final ImageProvider<Object>? image;

  @override
  Widget build(BuildContext context) {
    final String text = substring(userName, 0, 2).toUpperCase();

    return CircleAvatar(
      radius: radius,
      backgroundColor: CpColors.darkGoldBackgroundColor,
      foregroundImage: image,
      child: AnimatedDefaultTextStyle(
        duration: kThemeChangeDuration,
        style: _textStyle,
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

const TextStyle _textStyle = TextStyle(
  height: 1.4,
  fontSize: 32.0,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);
