import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../di.dart';
import '../../../routing.dart';
import '../../profile/screens/manage_profile_screen.dart';
import '../data/onboarding_repository.dart';
import 'no_email_and_password_screen.dart';

class OnboardingRoute extends GoRouteData {
  const OnboardingRoute({required this.finishPath});

  final String finishPath;

  @override
  String? redirect(BuildContext context, GoRouterState state) =>
      sl<OnboardingRepository>().hasSetupProfile
          ? OnboardingNoPasswordRoute(finishPath: finishPath).location
          : null;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ManageProfileScreen(
        onSubmitted: () => OnboardingNoPasswordRoute(finishPath: finishPath)
            .push<void>(context),
      );
}
