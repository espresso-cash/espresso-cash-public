import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class RequestTypeScreen extends StatelessWidget {
  const RequestTypeScreen({
    Key? key,
    required this.onLinkSelected,
    required this.onAddressSelected,
  }) : super(key: key);

  final VoidCallback onLinkSelected;
  final VoidCallback onAddressSelected;

  @override
  Widget build(BuildContext context) => CpActionSelector(
        appBarLeading: BackButton(onPressed: () => context.router.pop()),
        header: context.l10n.receiveFlowTitle,
        actions: [
          CpActionSelectorButton(
            text: context.l10n.receiveFlowLinkTitle,
            help: context.l10n.receiveFlowLinkDescription,
            onPressed: onLinkSelected,
          ),
          CpActionSelectorButton(
            text: context.l10n.receiveFlowSolanaAddress,
            onPressed: onAddressSelected,
          ),
        ],
      );
}
