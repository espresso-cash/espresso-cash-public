import 'package:flutter/material.dart';

import '../../../di.dart';
import '../data/onboarding_repository.dart';
import 'profile_screen.dart';
import 'view_recovery_phrase_screen.dart';

class OnboardingScreen {
  static void push(BuildContext context) {
    final hasConfirmedPassphrase =
        sl<OnboardingRepository>().hasConfirmedPassphrase;

    if (hasConfirmedPassphrase) {
      OnboardingProfileScreen.push(context);
    } else {
      ViewRecoveryPhraseScreen.push(
        context,
        onConfirmed: () => OnboardingProfileScreen.replace(context),
      );
    }
  }
}
