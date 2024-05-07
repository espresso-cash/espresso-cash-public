import 'package:flutter/material.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../l10n/l10n.dart';
import '../../../../../../ui/button.dart';
import '../../../../../../ui/content_padding.dart';
import '../../../../../../ui/theme.dart';
import '../../../../ui/rounded_rectangle.dart';

class PuzzleSuccessScreen extends StatelessWidget {
  const PuzzleSuccessScreen({super.key, required this.onDone});

  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          body: CpContentPadding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 110),
                Assets.icons.successCheck.svg(width: 72, height: 72),
                const SizedBox(height: 42),
                CpRoundedRectangle(
                  padding: const EdgeInsets.all(32),
                  backgroundColor: Colors.black,
                  child: Text(
                    '${context.l10n.backupPhrase_lblSuccessMessage1}\n\n${context.l10n.backupPhrase_lblSuccessMessage2}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 80),
                CpButton(
                  size: CpButtonSize.big,
                  width: double.infinity,
                  text: context.l10n.ok,
                  onPressed: onDone,
                ),
              ],
            ),
          ),
        ),
      );
}
