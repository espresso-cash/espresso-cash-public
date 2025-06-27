import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'colors.dart';

enum CpIconButtonVariant { dark, grey, light, black, transparent, inverted }

enum CpIconButtonSize { large, big, normal, small, micro }

class CpIconButton extends StatelessWidget {
  const CpIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.variant = CpIconButtonVariant.grey,
    this.size = CpIconButtonSize.normal,
  });

  final SvgPicture icon;
  final VoidCallback onPressed;
  final CpIconButtonVariant variant;
  final CpIconButtonSize size;

  Color get _backgroundColor => switch (variant) {
    CpIconButtonVariant.dark => CpColors.yellowColor,
    CpIconButtonVariant.grey => CpColors.greyIconBackgroundColor,
    CpIconButtonVariant.light => Colors.white,
    CpIconButtonVariant.black => CpColors.blackGreyColor,
    CpIconButtonVariant.transparent => Colors.transparent,
    CpIconButtonVariant.inverted => CpColors.deepGreyColor,
  };

  double get _size => switch (size) {
    CpIconButtonSize.large => 72,
    CpIconButtonSize.big => 40,
    CpIconButtonSize.normal => 34,
    CpIconButtonSize.small => 28,
    CpIconButtonSize.micro => 22,
  };

  @override
  Widget build(BuildContext context) => Container(
    width: _size,
    decoration: ShapeDecoration(shape: const CircleBorder(), color: _backgroundColor),
    child: IconButton(
      iconSize: _size,
      padding: const EdgeInsets.all(6),
      icon: icon,
      onPressed: onPressed,
    ),
  );
}
