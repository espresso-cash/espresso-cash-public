import 'package:flutter/material.dart';

import '../../../utils/routing.dart';
import 'puzzle_input_screen.dart';
import 'puzzle_success_screen.dart';
import 'puzzle_view_phrase_screen.dart';

extension PuzzleFlow on BuildContext {
  void launchPuzzleFlow() {
    final navigator = Navigator.of(this, rootNavigator: true);

    MaterialPageRoute<void> successRoute() => MaterialPageRoute(
          builder: (context) => PuzzleSuccessScreen(
            onDone: () => context.openFirstScreen(),
          ),
        );

    MaterialPageRoute<void> inputPhraseRoute(String phrase) =>
        MaterialPageRoute(
          builder: (context) => PuzzleInputScreen(
            correctPhrase: phrase,
            onConfirmed: () => navigator.pushAndRemoveUntil(
              successRoute(),
              (route) => route.isFirst,
            ),
          ),
        );

    navigator.push<void>(
      MaterialPageRoute(
        builder: (context) => PuzzleViewPhraseScreen(
          onConfirmed: (phrase) => navigator.push(inputPhraseRoute(phrase)),
        ),
      ),
    );
  }
}
