import 'package:cryptoplease/bl/outgoing_transfers/create_outgoing_transfer_bloc/nft/bloc.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/common/components/enter_address_input_widget.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/common/send_flow_router.dart';
import 'package:cryptoplease/presentation/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solana/solana.dart';

class EnterNonFungibleTokenAddressScreen extends StatefulWidget {
  const EnterNonFungibleTokenAddressScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<EnterNonFungibleTokenAddressScreen> {
  final _controller = TextEditingController();
  bool _isAddressValid = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(debounce(_onTextChange, 200));

    final initialAddress =
        context.read<NftCreateOutgoingTransferBloc>().state.recipientAddress;
    if (initialAddress != null) {
      _controller.text = initialAddress;
      _isAddressValid = isValidAddress(initialAddress);
    }
  }

  void _onTextChange() {
    setState(() {
      _isAddressValid = isValidAddress(_controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => EnterAddressInputWidget(
        controller: _controller,
        inputLabel: context.l10n.solanaAddressOfTheReceiver,
        inputPlaceholder: context.l10n.solanaAddress,
        onRecipientSelected: _isAddressValid
            ? () {
                final event = NftCreateOutgoingTransferEvent.recipientUpdated(
                  _controller.text,
                );
                context.read<NftCreateOutgoingTransferBloc>().add(event);
                context.read<SendFlowRouter>().onAddressSubmitted();
              }
            : null,
        onQrCodeSelected: context.read<SendFlowRouter>().onQrCodeSelected,
      );
}
