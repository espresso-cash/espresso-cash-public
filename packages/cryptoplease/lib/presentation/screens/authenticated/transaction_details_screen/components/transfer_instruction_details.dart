import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/screens/authenticated/transaction_details_screen/components/details_view.dart';
import 'package:cryptoplease/presentation/screens/authenticated/transaction_details_screen/components/value_views.dart';
import 'package:cryptoplease/presentation/screens/authenticated/transaction_details_screen/dto/transfer_instruction_data.dart';
import 'package:flutter/material.dart';

class TransferInstructionDetails extends StatelessWidget {
  const TransferInstructionDetails({
    Key? key,
    required this.data,
  }) : super(key: key);

  final TransferInstructionData data;

  @override
  Widget build(BuildContext context) {
    final amount = data.getAmount(DeviceLocale.localeOf(context));

    return DetailsView(
      title: context.l10n.transfer,
      fields: <String, Widget>{
        // TODO(IA): use the actual value (perhaps Transfer Checked)
        context.l10n.type: DetailsValue(value: context.l10n.transfer),
        context.l10n.from: DetailsAddressValue(address: data.from),
        context.l10n.to: DetailsAddressValue(address: data.to),
        context.l10n.amount: DetailsValue(value: amount),
      },
    );
  }
}
