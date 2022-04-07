import 'package:cryptoplease/bl/outgoing_transfers/create_outgoing_transfer_bloc/recipient_address.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/common/components/enter_address_input_widget.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/common/send_flow_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnterAddressScreen extends StatefulWidget {
  const EnterAddressScreen({
    Key? key,
    required this.initialAddress,
  }) : super(key: key);

  final String? initialAddress;

  @override
  _EnterAddressScreenState createState() => _EnterAddressScreenState();
}

class _EnterAddressScreenState extends State<EnterAddressScreen> {
  @override
  Widget build(BuildContext context) => Consumer<RecipientAddress>(
        builder: (context, recipient, _) => EnterAddressInputWidget(
          initialAddress: recipient.address ?? widget.initialAddress,
          inputLabel: context.l10n.solanaAddressOfTheReceiver,
          inputPlaceholder: context.l10n.solanaAddress,
          onRecipientSelected: (value) =>
              context.read<SendFlowRouter>().onAddressSubmitted(value),
          onQrCodeSelected: () =>
              context.read<SendFlowRouter>().onQrCodeSelected(),
        ),
      );
}
