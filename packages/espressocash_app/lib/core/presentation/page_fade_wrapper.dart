import 'package:flutter/material.dart';

import '../../ui/colors.dart';
import '../../ui/navigation_bar/navigation_bar.dart';

class PageFadeWrapper extends StatelessWidget {
  const PageFadeWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          child,
          const Positioned(
            bottom: cpNavigationBarheight,
            left: 0,
            right: 0,
            child: FadeGradient(
              height: 50,
              direction: FadeGradientDirection.bottomUp,
            ),
          ),
        ],
      );
}

enum FadeGradientDirection { topDown, bottomUp }

enum FadeGradientColor { white, dark }

class FadeGradient extends StatelessWidget {
  const FadeGradient({
    super.key,
    required this.height,
    required this.direction,
    this.color = FadeGradientColor.white,
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
