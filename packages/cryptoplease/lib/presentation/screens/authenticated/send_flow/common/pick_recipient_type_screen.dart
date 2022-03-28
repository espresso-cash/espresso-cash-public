import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/common/send_flow_router.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickRecipientTypeScreen extends StatefulWidget {
  const PickRecipientTypeScreen({Key? key}) : super(key: key);

  @override
  _PickRecipientTypeScreenState createState() =>
      _PickRecipientTypeScreenState();
}

class _PickRecipientTypeScreenState extends State<PickRecipientTypeScreen> {
  @override
  Widget build(BuildContext context) => CpActionSelector(
        appBarLeading: BackButton(onPressed: () => context.router.pop()),
        header: context.l10n.send,
        actions: [
          CpActionSelectorButton(
            text: context.l10n.anyoneByCreatingUniqueCode,
            help: context.l10n.pickRecipientTypeLongText,
            onPressed: () =>
                context.read<SendFlowRouter>().onSplitKeySelected(),
          ),
          CpActionSelectorButton(
            text: context.l10n.solanaAddress,
            onPressed: () => context.read<SendFlowRouter>().onDirectSelected(),
          ),
          CpActionSelectorButton(
            text: context.l10n.byScanningQRCode,
            onPressed: () => context.read<SendFlowRouter>().onQrCodeSelected(),
          ),
        ],
      );
}
