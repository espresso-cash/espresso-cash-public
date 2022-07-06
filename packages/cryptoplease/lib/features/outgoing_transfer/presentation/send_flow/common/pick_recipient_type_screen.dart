import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class PickRecipientTypeScreen extends StatelessWidget {
  const PickRecipientTypeScreen({
    Key? key,
    required this.onLinkSelected,
    required this.onDirectSelected,
    required this.onQrCodeSelected,
  }) : super(key: key);

  final VoidCallback onLinkSelected;
  final VoidCallback onDirectSelected;
  final VoidCallback onQrCodeSelected;

  @override
  Widget build(BuildContext context) => CpActionSelector(
        appBarLeading: BackButton(onPressed: () => context.router.pop()),
        header: context.l10n.send,
        actions: [
          CpActionSelectorButton(
            text: context.l10n.anyoneByCreatingUniqueCode,
            help: context.l10n.pickRecipientTypeLongText,
            onPressed: onLinkSelected,
          ),
          CpActionSelectorButton(
            text: context.l10n.solanaAddress,
            onPressed: onDirectSelected,
          ),
          CpActionSelectorButton(
            text: context.l10n.byScanningQRCode,
            onPressed: onQrCodeSelected,
          ),
        ],
      );
}
