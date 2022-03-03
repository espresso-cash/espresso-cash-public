import 'package:cryptoplease/bl/outgoing_transfers/create_outgoing_transfer_bloc/bloc.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/decorated_window.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/send_flow_router.dart';
import 'package:cryptoplease/presentation/utils.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:solana/solana.dart';

class EnterAddressScreen extends StatefulWidget {
  const EnterAddressScreen({Key? key}) : super(key: key);

  @override
  _EnterAddressScreenState createState() => _EnterAddressScreenState();
}

class _EnterAddressScreenState extends State<EnterAddressScreen> {
  final _controller = TextEditingController();
  bool _isAddressValid = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(debounce(_onTextChange, 200));

    final initialAddress =
        context.read<CreateOutgoingTransferBloc>().state.recipientAddress;
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
  Widget build(BuildContext context) => _Content(
        controller: _controller,
        inputLabel: context.l10n.solanaAddressOfTheReceiver,
        inputPlaceholder: context.l10n.solanaAddress,
        onRecipientSelected: _isAddressValid
            ? () {
                final event = CreateOutgoingTransferEvent.recipientUpdated(
                  _controller.text,
                );
                context.read<CreateOutgoingTransferBloc>().add(event);
                context.read<SendFlowRouter>().onAddressSubmitted();
              }
            : null,
      );
}

class _Content extends StatelessWidget {
  const _Content({
    Key? key,
    required this.inputLabel,
    required this.inputPlaceholder,
    required this.controller,
    this.onRecipientSelected,
  }) : super(key: key);

  final String inputLabel;
  final String inputPlaceholder;
  final TextEditingController controller;
  final VoidCallback? onRecipientSelected;

  void _setFromClipboard() {
    Clipboard.getData(Clipboard.kTextPlain).then((ClipboardData? data) {
      if (data != null) {
        controller.text = data.text ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) => AnnotatedRegion(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.white,
        ),
        child: DecoratedWindow(
          isScrollable: false,
          backgroundStyle: BackgroundStyle.light,
          hasLogo: false,
          hasAppBarBorder: false,
          bottomButton: CpContentPadding(
            child: CpButton(
              text: context.l10n.next,
              minWidth: double.infinity,
              onPressed: onRecipientSelected,
            ),
          ),
          child: CpContentPadding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: controller,
                  maxLines: 3,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: CpColors.primaryTextColor,
                    fontFamily: 'DIN',
                  ),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: CpColors.lightTextFieldBackgroundColor,
                    filled: true,
                    hintText: inputLabel,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CpButton(
                      text: context.l10n.paste,
                      size: CpButtonSize.micro,
                      onPressed: _setFromClipboard,
                    ),
                    const SizedBox(width: 8),
                    CpButton(
                      text: context.l10n.scanQRCode,
                      size: CpButtonSize.micro,
                      onPressed:
                          context.read<SendFlowRouter>().onQrCodeSelected,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
}
