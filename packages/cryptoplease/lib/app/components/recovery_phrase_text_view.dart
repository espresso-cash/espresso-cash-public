import 'package:cryptoplease/app/text_styles.dart';
import 'package:cryptoplease/core/presentation/snackbars.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RecoveryPhraseTextView extends StatelessWidget {
  const RecoveryPhraseTextView({
    Key? key,
    this.phrase = '',
    this.backgroundColor,
    this.hasCopyButton = true,
  }) : super(key: key);

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
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
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
                  ),
                ),
              ),
          ],
        ),
      );
}
