import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../l10n/l10n.dart';
import 'button.dart';
import 'colors.dart';
import 'snackbar.dart';
import 'theme.dart';

class RecoveryPhraseTextView extends StatelessWidget {
  const RecoveryPhraseTextView({
    super.key,
    this.phrase = '',
    this.backgroundColor,
    this.hasCopyButton = true,
  });

  final String phrase;
  final Color? backgroundColor;
  final bool hasCopyButton;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor ?? CpColors.darkBackground,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                phrase,
                textAlign: TextAlign.justify,
                style: twelveWordsTextStyle,
              ),
            ),
            if (hasCopyButton)
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.only(right: 24, bottom: 12),
                  height: kToolbarHeight / 2,
                  child: CpButton(
                    text: context.l10n.copy,
                    minWidth: 80,
                    onPressed: () {
                      final data = ClipboardData(text: phrase);
                      Clipboard.setData(data);
                      showClipboardSnackbar(context);
                    },
                    size: CpButtonSize.micro,
                  ),
                ),
              ),
          ],
        ),
      );
}
