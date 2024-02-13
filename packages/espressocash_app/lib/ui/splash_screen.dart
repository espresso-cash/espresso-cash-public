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
  Widget build(BuildContext context) => const CpTheme.black(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: CpColors.yellowSplashBackgroundColor,
          ),
          child: Center(
            child: SplashLogo(),
          ),
        ),
      );
}

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) => Hero(
        tag: 'logo',
        child: Assets.images.logo.image(height: 66),
      );
}
