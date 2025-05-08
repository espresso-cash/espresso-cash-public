import 'package:flutter/material.dart';

class CpContentPadding extends StatelessWidget {
  const CpContentPadding({super.key, required this.child, this.isBottom = true});

  final Widget child;
  final bool isBottom;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(top: 24, bottom: isBottom ? 24 : 0, left: 24, right: 24),
    child: child,
  );
}
