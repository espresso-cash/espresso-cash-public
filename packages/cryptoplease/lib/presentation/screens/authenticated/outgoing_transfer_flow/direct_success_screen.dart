import 'package:cryptoplease/bl/outgoing_transfers/outgoing_payment.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/tx_result_screen.dart';
import 'package:flutter/material.dart';

class DirectSuccessScreen extends StatelessWidget {
  const DirectSuccessScreen({
    Key? key,
    required this.transfer,
  }) : super(key: key);

  final OutgoingTransferDirect transfer;

  @override
  Widget build(BuildContext context) => TxResultScreen(
        signature: transfer.signature,
        text: context.l10n.sent,
        icon: Assets.icons.successIconLightBg,
      );
}
