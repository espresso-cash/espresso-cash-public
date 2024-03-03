import 'package:flutter/material.dart';

import '../../routing.dart';
import 'screens/quiz_intro_screen.dart';

extension BuildContextExt on BuildContext {
  void launchViewRecoveryPhraseFlow() =>
      const QuizIntroRoute().push<void>(this);
}
