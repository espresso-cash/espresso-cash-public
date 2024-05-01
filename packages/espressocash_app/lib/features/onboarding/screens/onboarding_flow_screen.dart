import 'package:flutter/material.dart';

import '../../../di.dart';
import '../data/onboarding_repository.dart';
import 'profile_screen.dart';
import 'view_recovery_phrase_screen.dart';

class OnboardingFlowScreen {
  static void open(BuildContext context, {NavigatorState? navigator}) {
    final hasConfirmedPassphrase =
        sl<OnboardingRepository>().hasConfirmedPassphrase;

    if (hasConfirmedPassphrase) {
      OnboardingProfileScreen.open(context, navigator: navigator);
    } else {
      ViewRecoveryPhraseScreen.open(
        context,
        onConfirmed: () => OnboardingProfileScreen.open(
          context,
          navigator: navigator,
        ),
        navigator: navigator,
      );
    }
  }
}
