import 'package:cryptoplease/app/components/snackbars.dart';
import 'package:cryptoplease/core/presentation/utils.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/ui/button.dart';
import 'package:cryptoplease/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HelpBottomSheet extends StatelessWidget {
  const HelpBottomSheet({Key? key}) : super(key: key);

  static Future<void> show(BuildContext context) => showModalBottomSheet(
        context: context,
        builder: (_) => const HelpBottomSheet(),
        backgroundColor: CpColors.darkBackground,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.l10n.contactUs,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 31,
                fontWeight: FontWeight.bold,
                color: CpColors.lightButtonBackgroundColor,
              ),
            ),
            const SizedBox(height: 30),
            Text.rich(
              TextSpan(
                text: '${context.l10n.supportSubtitle}\n',
                children: [
                  TextSpan(
                    text: context.l10n.supportEmail,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
                style: const TextStyle(
                  fontSize: 21,
                  color: CpColors.lightButtonBackgroundColor,
                ),
              ),
            ),
            const SizedBox(height: 30),
            CpButton(
              text: context.l10n.copy,
              minWidth: 250,
              onPressed: () {
                Clipboard.setData(
                  ClipboardData(text: context.l10n.supportEmail),
                );
                showClipboardSnackbar(context);
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(height: 12),
            CpButton(
              text: context.l10n.openEmailApp,
              minWidth: 250,
              onPressed: () async {
                final uri = Uri(
                  scheme: 'mailto',
                  path: context.l10n.supportEmail,
                ).toString();
                await context.openLink(uri);
              },
            ),
          ],
        ),
      );
}
