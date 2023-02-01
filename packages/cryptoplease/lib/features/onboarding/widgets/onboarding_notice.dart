import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';

class OnboardingNotice extends StatelessWidget {
  const OnboardingNotice({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 125,
        child: GestureDetector(
          onTap: () {
            print('tapped');
          },
          child: Assets.rive.onboardingNotice.rive(
            fit: BoxFit.fitWidth,
          ),
        ),
      );
}
