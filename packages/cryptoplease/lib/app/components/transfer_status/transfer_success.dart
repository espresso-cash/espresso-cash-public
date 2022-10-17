import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/ui/button.dart';
import 'package:cryptoplease/ui/status_screen.dart';
import 'package:cryptoplease/ui/status_widget.dart';
import 'package:flutter/material.dart';

class TransferSuccess extends StatelessWidget {
  const TransferSuccess({super.key});

  @override
  Widget build(BuildContext context) => StatusScreen(
        title: context.l10n.splitKeyTransferTitle,
        statusTitle: Text(context.l10n.splitKeySuccessMessage1),
        statusContent: Text(context.l10n.splitKeySuccessMessage2),
        statusType: CpStatusType.success,
        backgroundImage:
            Assets.icons.logoBgGreen.svg(alignment: Alignment.bottomCenter),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 160),
              CpButton(
                size: CpButtonSize.big,
                width: double.infinity,
                text: context.l10n.ok,
                onPressed: () => context.router.pop(),
              )
            ],
          ),
        ),
      );
}
