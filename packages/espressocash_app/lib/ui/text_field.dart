import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

enum CpTextFieldBorder { rounded, stadium }

class CpTextField extends StatelessWidget {
  const CpTextField({
    super.key,
    this.controller,
    this.placeholder,
    this.margin,
    this.inputType,
    this.placeholderColor = CpColors.placeholderLightColor,
    this.backgroundColor = CpColors.lightGreyBackground,
    this.readOnly = false,
    this.fontSize = 20,
    this.disabled = false,
    this.padding = const EdgeInsets.all(24),
    this.suffix,
    this.border = CpTextFieldBorder.stadium,
    this.prefix,
  });

  final TextEditingController? controller;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final Color placeholderColor;
  final String? placeholder;
  final EdgeInsetsGeometry? margin;
  final bool readOnly;
  final double fontSize;
  final bool disabled;
  final TextInputType? inputType;
  final Widget? suffix;
  final Widget? prefix;
  final CpTextFieldBorder border;

  @override
  Widget build(BuildContext context) {
    final prefix = this.prefix;

    return Container(
      margin: margin,
      decoration: border == CpTextFieldBorder.stadium
          ? ShapeDecoration(
              color: backgroundColor,
              shape: const StadiumBorder(),
            )
          : BoxDecoration(
              color: backgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
      child: CupertinoTextField(
        enabled: !disabled,
        decoration: const BoxDecoration(),
        suffix: suffix,
        padding: padding,
        readOnly: readOnly,
        textAlignVertical: TextAlignVertical.center,
        controller: controller,
        maxLines: 1,
        cursorColor: CpColors.yellowColor,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: fontSize,
          color: CpColors.primaryTextColor,
          height: 1.2,
        ),
        placeholder: placeholder,
        keyboardType: inputType,
        keyboardAppearance: Theme.of(context).brightness,
        placeholderStyle: TextStyle(color: placeholderColor),
        prefix: prefix == null
            ? null
            : Padding(
                padding: const EdgeInsets.only(left: 16),
                child: prefix,
              ),
      ),
    );
  }
}
