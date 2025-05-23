import 'package:flutter/material.dart';

import 'colors.dart';

enum CpTextButtonVariant { light, dark, inverted, grey }

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

  Color get _foregroundColor => switch (variant) {
    CpTextButtonVariant.dark => Colors.white,
    CpTextButtonVariant.inverted => Colors.black,
    CpTextButtonVariant.light => CpColors.primaryColor,
    CpTextButtonVariant.grey => const Color(0xff757575),
  };

  @override
  Widget build(BuildContext context) => GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: onPressed,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: Text(
        text,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: _foregroundColor),
      ),
    ),
  );
}
