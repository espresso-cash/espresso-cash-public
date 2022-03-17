import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/snackbars.dart';
import 'package:cryptoplease/presentation/utils.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HelpBottomSheet extends StatelessWidget {
  const HelpBottomSheet({Key? key}) : super(key: key);

  static Future<void> show(BuildContext context) => showModalBottomSheet(
        context: context,
        builder: (_) => const HelpBottomSheet(),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.l10n.supportSubtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: CpColors.secondaryTextColor,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              context.l10n.supportEmail,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: CpColors.primaryTextColor,
              ),
            ),
            const SizedBox(height: 24),
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CpButton(
                  text: context.l10n.copy,
                  onPressed: () async {
                    await Clipboard.setData(
                      ClipboardData(text: context.l10n.supportEmail),
                    );
                    showClipboardSnackbar(context);
                  },
                ),
                CpButton(
                  text: context.l10n.openEmailApp,
                  onPressed: () async {
                    final uri = Uri(
                      scheme: 'mailto',
                      path: context.l10n.supportEmail,
                    ).toString();
                    await context.openLink(uri);
                  },
                ),
              ],
            )
          ],
        ),
      );
}
