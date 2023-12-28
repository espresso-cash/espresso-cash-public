import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'src/screens/view_phrase_flow_screen.dart';

extension BuildContextExt on BuildContext {
  void launchViewRecoveryPhraseFlow() =>
      router.push(ViewPhraseFlowScreen.route());
}
