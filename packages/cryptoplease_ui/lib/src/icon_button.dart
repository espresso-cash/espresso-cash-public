import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class CpIconButton extends StatelessWidget {
  const CpIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.size = 32,
  }) : super(key: key);

  final IconData icon;
  final double size;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Container(
        width: size,
        decoration: const ShapeDecoration(
          shape: CircleBorder(),
          color: CpColors.greyIconBackgroundColor,
        ),
        child: IconButton(
          iconSize: size / 2,
          icon: Icon(
            icon,
            color: CpColors.darkBackground,
          ),
          onPressed: onPressed,
        ),
      );
}
