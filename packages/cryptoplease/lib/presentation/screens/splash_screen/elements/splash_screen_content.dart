import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class SplashScreenContent extends StatelessWidget {
  const SplashScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CpBackgroundGradient(
        child: Center(
          child: Assets.images.splash.image(height: 195),
        ),
      );
}
