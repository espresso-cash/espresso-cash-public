import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'src/screens/onboarding_flow_screen.dart';

export 'src/widgets/onboarding_notice.dart';

extension BuildContextExt on BuildContext {
  Future<bool?> launchOnboardingFlow() =>
      router.push<bool?>(OnboardingFlowScreen.route());
}
