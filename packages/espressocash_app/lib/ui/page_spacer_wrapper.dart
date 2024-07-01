import 'package:flutter/material.dart';

import 'colors.dart';

class PageSpacerWrapper extends StatelessWidget {
  const PageSpacerWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final double bottom = MediaQuery.paddingOf(context).bottom;

    return Stack(
      children: [
        child,
        Positioned(
          bottom: bottom,
          left: 0,
          right: 0,
          child: const SolidPadding(
            height: 10,
            direction: FadeGradientDirection.bottomUp,
            color: FadeGradientColor.dark,
          ),
        ),
      ],
    );
  }
}

enum FadeGradientDirection { topDown, bottomUp }

enum FadeGradientColor { white, dark }

class FadeGradient extends StatelessWidget {
  const FadeGradient({
    super.key,
    required this.height,
    required this.direction,
    this.color = FadeGradientColor.dark,
  });

  final double height;
  final FadeGradientDirection direction;
  final FadeGradientColor color;

  @override
  Widget build(BuildContext context) => IgnorePointer(
        child: Container(
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: direction.begin,
              end: direction.end,
              colors: color == FadeGradientColor.white
                  ? [
                      Colors.white,
                      Colors.white.withOpacity(0),
                    ]
                  : [
                      CpColors.darkBackground,
                      CpColors.darkBackground.withOpacity(0),
                    ],
            ),
          ),
        ),
      );
}

class SolidPadding extends StatelessWidget {
  const SolidPadding({
    super.key,
    required this.height,
    required this.direction,
    this.color = FadeGradientColor.dark,
  });

  final double height;
  final FadeGradientDirection direction;
  final FadeGradientColor color;

  @override
  Widget build(BuildContext context) => IgnorePointer(
        child: Container(
          height: height,
          decoration: const BoxDecoration(
            color: CpColors.dashboardBackgroundColor,
          ),
        ),
      );
}

extension on FadeGradientDirection {
  Alignment get begin {
    switch (this) {
      case FadeGradientDirection.topDown:
        return Alignment.topCenter;
      case FadeGradientDirection.bottomUp:
        return Alignment.bottomCenter;
    }
  }

  Alignment get end {
    switch (this) {
      case FadeGradientDirection.topDown:
        return Alignment.bottomCenter;
      case FadeGradientDirection.bottomUp:
        return Alignment.topCenter;
    }
  }
}
