import 'package:flutter/material.dart';

import 'colors.dart';
import 'info_icon.dart';
import 'rounded_rectangle.dart';

enum CpInfoVariant { light, dark, black }

class CpInfoWidget extends StatelessWidget {
  const CpInfoWidget({
    super.key,
    required this.message,
    this.variant = CpInfoVariant.light,
    this.padding = const EdgeInsets.all(24),
    this.infoRadius = 14,
    this.iconSize = 20,
  });

  final Widget message;
  final EdgeInsetsGeometry padding;
  final CpInfoVariant variant;
  final double infoRadius;
  final double? iconSize;

  Color get _iconColor => switch (variant) {
    CpInfoVariant.light => CpColors.backgroundAccentColor,
    CpInfoVariant.dark => CpColors.blackGreyColor,
    CpInfoVariant.black => Colors.black,
  };

  @override
  Widget build(BuildContext context) {
    final content = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: CircleAvatar(
            maxRadius: infoRadius,
            backgroundColor: CpColors.yellowColor,
            child: CpInfoIcon(iconColor: _iconColor, height: iconSize),
          ),
        ),
        Flexible(
          child: DefaultTextStyle.merge(
            style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w500),
            child: message,
          ),
        ),
      ],
    );

    return switch (variant) {
      CpInfoVariant.dark => Padding(padding: padding, child: content),
      CpInfoVariant.light => CpRoundedRectangle(
        backgroundColor: CpColors.backgroundAccentColor,
        padding: padding,
        child: content,
      ),
      CpInfoVariant.black => CpRoundedRectangle(
        backgroundColor: Colors.black,
        padding: padding,
        child: content,
      ),
    };
  }
}
