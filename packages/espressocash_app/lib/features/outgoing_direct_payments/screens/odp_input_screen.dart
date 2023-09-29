import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../routes.gr.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/bottom_button.dart';
import '../../../ui/icon_button.dart';
import '../../../ui/text_field.dart';
import '../../../ui/theme.dart';
import '../../wallet_flow/screens/pay_flow_screen.dart';
import '../data/blockchain.dart';
import 'network_picker_screen.dart';

typedef ODPInputResponse = void Function(Blockchain network, String address);

@RoutePage()
class ODPInputScreen extends StatefulWidget {
  const ODPInputScreen({super.key, required this.onSubmit});

  final ODPInputResponse onSubmit;

  static const route = ODPInputRoute.new;

  @override
  State<ODPInputScreen> createState() => _ODPInputScreenState();
}

class _ODPInputScreenState extends State<ODPInputScreen> {
  late final TextEditingController _walletAddressController =
      TextEditingController();

  Blockchain _selectedNetwork = Blockchain.solana;
  final bool _showNetworkPicker = Blockchain.values.length > 1;

  bool get _isValid => _selectedNetwork.validate(_walletAddressController.text);

  void _handleSubmitted() => widget.onSubmit(
        _selectedNetwork,
        _walletAddressController.text,
      );

  void _handleOnNetworkTap() => context.router.push(
        NetworkPickerScreen.route(
          initial: _selectedNetwork,
          onSubmitted: (network) {
            context.router.pop();
            setState(() {
              _selectedNetwork = network;
            });
          },
        ),
      );

  Future<void> _handleOnQrScan() async {
    // TODO launch qr
    setState(() {
      _walletAddressController.text = 'TODO';
    });
  }

  @override
  void dispose() {
    _walletAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          appBar: CpAppBar(
            title: Text('SEND TO A WALLET ADDRESS'.toUpperCase()),
          ),
          body: SafeArea(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  PayItem(
                    title: 'Networks',
                    buttonText: _selectedNetwork.name,
                    onPressed: _showNetworkPicker ? _handleOnNetworkTap : null,
                    buttonTrailing: _showNetworkPicker
                        ? const Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Colors.white,
                            size: 34,
                          )
                        : null,
                  ),
                  _WalletTextField(
                    title: 'Wallet Address',
                    controller: _walletAddressController,
                    onQrScan: _handleOnQrScan,
                  ),
                  const Spacer(),
                  ListenableBuilder(
                    listenable: _walletAddressController,
                    builder: (context, child) => CpBottomButton(
                      text: context.l10n.next,
                      onPressed: _isValid ? _handleSubmitted : null,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}

class _WalletTextField extends StatelessWidget {
  const _WalletTextField({
    required this.title,
    required this.controller,
    required this.onQrScan,
  });

  final String title;
  final TextEditingController controller;
  final VoidCallback onQrScan;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 12),
            CpTextField(
              controller: controller,
              placeholder: 'Type, Paste or Scan Address Here',
              backgroundColor: const Color(0xFF4D4B4C),
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 18,
              ),
              textColor: Colors.white,
              fontSize: 16,
              suffix: Padding(
                padding: const EdgeInsets.only(right: 24),
                child: CpIconButton(
                  onPressed: onQrScan,
                  icon: Assets.icons.qrScanner.svg(color: Colors.white),
                  variant: CpIconButtonVariant.black,
                ),
              ),
            ),
          ],
        ),
      );
}
