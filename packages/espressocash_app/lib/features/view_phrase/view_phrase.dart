import 'package:flutter/material.dart';

import 'screens/quiz_intro_screen.dart';

extension BuildContextExt on BuildContext {
  void launchViewRecoveryPhraseFlow() => QuizIntroScreen.push(this);
}
