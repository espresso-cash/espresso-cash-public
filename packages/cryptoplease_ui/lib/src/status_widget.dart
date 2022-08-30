import 'package:flutter/material.dart';

class CpStatusWidget extends StatelessWidget {
  const CpStatusWidget({
    Key? key,
    required this.child,
    required this.backgroundColor,
    this.padding = const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
  }) : super(key: key);

  final Widget child;
  final Color? backgroundColor;
  final EdgeInsetsGeometry padding;

  static const _radius = Radius.circular(32);

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.only(
            bottomLeft: _radius,
            bottomRight: _radius,
            topLeft: _radius,
          ),
        ),
        child: Padding(
          padding: padding,
          child: Center(child: child),
        ),
      );
}
