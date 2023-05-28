import 'package:flutter/material.dart';

import 'colors.dart';

enum CpTextButtonVariant { light, dark, inverted }

class CpTextButton extends StatelessWidget {
  const CpTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = CpTextButtonVariant.dark,
  });

  final String text;
  final VoidCallback? onPressed;
  final CpTextButtonVariant variant;

  Color get _foregroundColor {
    switch (variant) {
      case CpTextButtonVariant.dark:
        return Colors.white;
      case CpTextButtonVariant.inverted:
        return Colors.black;
      case CpTextButtonVariant.light:
        return CpColors.primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: _foregroundColor,
          ),
        ),
      );
}
