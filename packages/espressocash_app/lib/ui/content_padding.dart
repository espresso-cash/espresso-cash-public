import 'package:flutter/material.dart';

class CpContentPadding extends StatelessWidget {
  const CpContentPadding({
    super.key,
    required this.child,
    this.bottom = true,
  });

  final Widget child;
  final bool bottom;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(
          top: 24,
          bottom: bottom ? 24 : 0,
          left: 24,
          right: 24,
        ),
        child: child,
      );
}
