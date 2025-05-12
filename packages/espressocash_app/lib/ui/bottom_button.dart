import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'button.dart';

class CpBottomButton extends StatelessWidget {
  const CpBottomButton({
    super.key,
    required this.text,
    this.variant = CpButtonVariant.dark,
    this.horizontalPadding = 40,
    this.onPressed,
  });

  final String text;
  final VoidCallback? onPressed;
  final CpButtonVariant variant;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: 24.h, left: horizontalPadding.w, right: horizontalPadding.w),
    child: CpButton(
      key: keyBottomButton,
      variant: variant,
      size: CpButtonSize.big,
      width: double.infinity,
      onPressed: onPressed,
      text: text,
    ),
  );
}

const keyBottomButton = Key('bottomButton');
