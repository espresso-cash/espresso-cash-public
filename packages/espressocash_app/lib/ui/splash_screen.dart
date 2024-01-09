import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';
import '../routes.gr.dart';
import 'colors.dart';
import 'theme.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const route = SplashRoute.new;

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                CpColors.yellowSplashBackgroundColor,
                Color(0xFFDF6D0B),
              ],
              stops: [0.2, 1.0],
            ),
          ),
          child: Center(
            child: Assets.images.logoIcon.image(height: 101),
          ),
        ),
      );
}
