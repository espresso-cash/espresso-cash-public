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
  Widget build(BuildContext context) => Hero(
        tag: 'splash',
        child: CpTheme.black(
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: CpColors.yellowSplashBackgroundColor,
            ),
            child: Center(
              child: Assets.images.logoIcon.image(height: 101),
            ),
          ),
        ),
      );
}
