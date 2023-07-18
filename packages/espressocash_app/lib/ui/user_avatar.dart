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
    final double fontSize = (_fontSizeFactor * radius).roundToDouble();
    final String text = substring(userName, 0, 1).toUpperCase();

    return CircleAvatar(
      radius: radius,
      backgroundColor: CpColors.purple,
      foregroundImage: image,
      child: AnimatedDefaultTextStyle(
        duration: kThemeChangeDuration,
        style: TextStyle(
          fontSize: fontSize,
          height: 1,
          color: Colors.white,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

const _fontSizeFactor = 1.1667;
