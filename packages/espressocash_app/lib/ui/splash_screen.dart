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
            color: CpColors.yellowSplashBackgroundColor,
          ),
          child: Center(
            child: Assets.images.logo.image(height: 66),
          ),
        ),
      );
}
