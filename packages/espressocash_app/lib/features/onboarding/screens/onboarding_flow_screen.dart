import 'dart:async';

import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../country_picker/screens/country_picker_screen.dart';
import '../data/onboarding_repository.dart';
import 'view_recovery_phrase_screen.dart';

class OnboardingFlowScreen {
  static Future<void> open(
    BuildContext context, {
    required VoidCallback onConfirmed,
    NavigatorState? navigator,
  }) async {
    final hasConfirmedPassphrase =
        sl<OnboardingRepository>().hasConfirmedPassphrase;

    if (hasConfirmedPassphrase) {
      await CountryPickerScreen.open(
        context,
        navigator: navigator,
      );

      if (context.mounted) {
        unawaited(Future.microtask(() => onConfirmed()));
      }
    } else {
      ViewRecoveryPhraseScreen.open(
        context,
        navigator: navigator,
        onConfirmed: () async {
          await CountryPickerScreen.open(
            context,
            navigator: navigator,
          );

          if (context.mounted) {
            unawaited(Future.microtask(() => onConfirmed()));
          }
        },
      );
    }
  }
}
