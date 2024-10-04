import 'package:flutter/material.dart';

import 'button.dart';

class CpBottomButton extends StatelessWidget {
  const CpBottomButton({
    super.key,
    required this.text,
    this.horizontalPadding = 40,
    this.onPressed,
  });

  final String text;
  final VoidCallback? onPressed;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.only(
          bottom: 20,
          left: horizontalPadding,
          right: horizontalPadding,
        ),
        child: CpButton(
          key: keyBottomButton,
          size: CpButtonSize.big,
          width: double.infinity,
          onPressed: onPressed,
          text: text,
        ),
      );
}

const keyBottomButton = Key('bottomButton');
