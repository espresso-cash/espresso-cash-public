import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

enum CpTextFieldBorder { rounded, stadium }

class CpTextField extends StatelessWidget {
  const CpTextField({
    super.key,
    this.controller,
    this.placeholder,
    this.margin,
    this.inputType,
    this.inputFormatters,
    this.placeholderColor = CpColors.placeholderLightColor,
    this.backgroundColor = CpColors.lightGreyBackground,
    this.isReadOnly = false,
    this.fontSize = 20,
    this.fontWeight = FontWeight.normal,
    this.isDisabled = false,
    this.padding = const EdgeInsets.all(24),
    this.suffix,
    this.border = CpTextFieldBorder.stadium,
    this.prefix,
    this.textColor = CpColors.primaryTextColor,
    this.textAlign = TextAlign.start,
    this.textInputAction,
    this.isMultiLine = false,
    this.textCapitalization = TextCapitalization.none,
    this.shouldAutocorrect = true,
  });

  final TextEditingController? controller;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final Color placeholderColor;
  final String? placeholder;
  final EdgeInsetsGeometry? margin;
  final bool isReadOnly;
  final double fontSize;
  final FontWeight fontWeight;
  final bool isDisabled;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffix;
  final Widget? prefix;
  final CpTextFieldBorder border;
  final Color? textColor;
  final TextAlign textAlign;
  final TextInputAction? textInputAction;
  final bool? isMultiLine;
  final TextCapitalization textCapitalization;
  final bool shouldAutocorrect;

  @override
  Widget build(BuildContext context) {
    final prefix = this.prefix;
    final isMultiLine = this.isMultiLine ?? false;

    return Container(
      margin: margin,
      decoration:
          border == CpTextFieldBorder.stadium
              ? ShapeDecoration(color: backgroundColor, shape: const StadiumBorder())
              : BoxDecoration(
                color: backgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
      child: CupertinoTextField(
        autocorrect: shouldAutocorrect,
        enabled: !isDisabled,
        decoration: const BoxDecoration(),
        suffix: suffix,
        padding: padding,
        readOnly: isReadOnly,
        textAlignVertical: TextAlignVertical.center,
        controller: controller,
        maxLines: isMultiLine ? null : 1,
        cursorColor: CpColors.yellowColor,
        style: TextStyle(fontWeight: fontWeight, fontSize: fontSize, color: textColor, height: 1.2),
        textAlign: textAlign,
        placeholder: placeholder,
        keyboardType: inputType,
        inputFormatters: inputFormatters,
        textCapitalization: textCapitalization,
        keyboardAppearance: Theme.of(context).brightness,
        placeholderStyle: TextStyle(color: placeholderColor),
        textInputAction: textInputAction,
        prefix: prefix,
      ),
    );
  }
}

class FittedTextEditingController extends TextEditingController {
  FittedTextEditingController({super.text});

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) => TextSpan(
    style: style,
    children: [
      WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: LayoutBuilder(
          builder:
              (BuildContext context, BoxConstraints constraints) =>
                  FittedBox(fit: BoxFit.scaleDown, child: Text(text, style: style)),
        ),
      ),
    ],
  );
}
