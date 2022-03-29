import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/screens/authenticated/receive_flow/flow.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestTypeScreen extends StatelessWidget {
  const RequestTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CpActionSelector(
        appBarLeading: BackButton(onPressed: () => context.router.pop()),
        header: context.l10n.receiveFlowTitle,
        actions: [
          CpActionSelectorButton(
            text: context.l10n.receiveFlowLinkTitle,
            help: context.l10n.receiveFlowLinkDescription,
            onPressed: () => context.read<ReceiveFlowRouter>().onLinkSelected(),
          ),
          CpActionSelectorButton(
            text: context.l10n.receiveFlowSolanaAddress,
            onPressed: () =>
                context.read<ReceiveFlowRouter>().onAddressSelected(),
          ),
        ],
      );
}
