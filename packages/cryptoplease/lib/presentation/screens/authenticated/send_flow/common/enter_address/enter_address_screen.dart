import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/common/components/enter_address_input_widget.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/common/send_flow_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solana/solana.dart';

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
  final _controller = TextEditingController();
  bool _isAddressValid = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChange);

    final initialAddress = widget.initialAddress;
    if (initialAddress != null) {
      _controller.text = initialAddress;
      _isAddressValid = isValidAddress(initialAddress);
    }
  }

  void _onTextChange() {
    final isValid = isValidAddress(_controller.text);
    if (isValid != _isAddressValid) {
      setState(() => _isAddressValid = isValid);
    }
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
                context
                    .read<SendFlowRouter>()
                    .onAddressSubmitted(_controller.text);
              }
            : null,
        onQrCodeSelected: context.read<SendFlowRouter>().onQrCodeSelected,
      );
}
