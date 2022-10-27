import 'package:cryptoplease/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CpIconButton extends StatelessWidget {
  const CpIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final SvgPicture icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Container(
        width: 34,
        decoration: const ShapeDecoration(
          shape: CircleBorder(),
          color: CpColors.greyIconBackgroundColor,
        ),
        child: IconButton(
          iconSize: 15,
          icon: icon,
          onPressed: onPressed,
        ),
      );
}
