import 'package:flutter/material.dart';

class RoundCornersContainer extends StatelessWidget {
  const RoundCornersContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => Material(
          child: Container(
            width: constraints.maxWidth,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              color: Colors.white,
            ),
            child: child,
          ),
        ),
      );
}
