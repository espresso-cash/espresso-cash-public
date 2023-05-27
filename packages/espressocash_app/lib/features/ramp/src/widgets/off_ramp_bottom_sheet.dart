import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';
import '../../../../ui/button.dart';
import '../../../../ui/colors.dart';

class OffRampBottomSheet extends StatelessWidget {
  const OffRampBottomSheet({super.key});

  static Future<void> show(BuildContext context) => showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        builder: (_) => const OffRampBottomSheet(),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.l10n.cashOut.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: CpColors.darkBackground,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                context.l10n.comingSoon,
                style: const TextStyle(
                  fontSize: 17,
                  color: CpColors.darkBackground,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              CpButton(
                text: context.l10n.ok,
                minWidth: 250,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      );
}
