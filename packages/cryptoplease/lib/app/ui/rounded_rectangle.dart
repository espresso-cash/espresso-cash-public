import 'package:cryptoplease/app/ui/colors.dart';
import 'package:flutter/material.dart';

/// Container that has all but top-right corner rounded.
class CpRoundedRectangle extends StatelessWidget {
  const CpRoundedRectangle({
    super.key,
    required this.child,
    this.backgroundColor,
    this.margin,
    this.padding,
  });

  final Widget child;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) => Container(
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor ?? CpColors.darkBackground,
          borderRadius: const BorderRadius.only(
            bottomLeft: _radius,
            bottomRight: _radius,
            topLeft: _radius,
          ),
        ),
        child: child,
      );
}

const _radius = Radius.circular(39);
