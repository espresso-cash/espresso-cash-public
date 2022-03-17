import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/snackbars.dart';
import 'package:cryptoplease/presentation/text_styles.dart';
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
          color: backgroundColor ?? CpColors.lightButtonBackgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(7)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
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
                  margin: const EdgeInsets.only(right: 12, bottom: 12),
                  height: kToolbarHeight / 2,
                  child: CpButton(
                    text: context.l10n.copy,
                    minWidth: 80,
                    onPressed: () async {
                      final data = ClipboardData(text: phrase);
                      await Clipboard.setData(data);
                      showClipboardSnackbar(context);
                    },
                  ),
                ),
              ),
          ],
        ),
      );
}
