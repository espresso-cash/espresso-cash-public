import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../di.dart';
import '../../../routing.dart';
import '../../authenticated/screens/main_screen.dart';
import '../data/onboarding_repository.dart';
import 'profile_screen.dart';
import 'view_recovery_phrase_screen.dart';

class OnboardingRoute extends GoRouteData {
  const OnboardingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final hasConfirmedPassphrase =
        sl<OnboardingRepository>().hasConfirmedPassphrase;

    return hasConfirmedPassphrase
        ? OnboardingProfileScreen(
            onConfirmed: () => const HomeRoute().go(context),
          )
        : ViewRecoveryPhraseScreen(
            onConfirmed: () => const OnboardingProfileRoute().go(context),
          );
  }
}
