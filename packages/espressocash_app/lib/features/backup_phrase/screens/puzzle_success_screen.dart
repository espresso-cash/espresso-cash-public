import 'package:flutter/material.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../l10n/l10n.dart';
import '../../../../../../ui/button.dart';
import '../../../../../../ui/content_padding.dart';
import '../../../../../../ui/theme.dart';
import '../../../../ui/rounded_rectangle.dart';
import '../../../di.dart';
import '../services/puzzle_reminder_bloc.dart';

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
                const CpRoundedRectangle(
                  padding: EdgeInsets.all(32),
                  backgroundColor: Colors.black,
                  child: _SuccessMessage(),
                ),
                const SizedBox(height: 80),
                CpButton(
                  size: CpButtonSize.big,
                  width: double.infinity,
                  text: context.l10n.ok,
                  onPressed: () {
                    sl<PuzzleReminderBloc>()
                        .add(const PuzzleReminderEvent.solved());
                    onDone();
                  },
                ),
              ],
            ),
          ),
        ),
      );
}

class _SuccessMessage extends StatelessWidget {
  const _SuccessMessage();

  @override
  Widget build(BuildContext context) => Text(
        context.l10n.backupPhrase_lblSuccessMessage,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
      );
}
