import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/back_button.dart';
import '../../../ui/bottom_button.dart';
import '../../../ui/colors.dart';
import '../../../ui/icon_button.dart';
import '../../../ui/onboarding_screen.dart';
import '../../../ui/text_field.dart';
import '../../../ui/theme.dart';
import '../../blockchain/models/blockchain.dart';
import '../../qr_scanner/widgets/build_context_ext.dart';
import 'network_picker_screen.dart';

typedef ODPInputResponse = void Function(Blockchain network, String address);

class ODPInputScreen extends StatefulWidget {
  const ODPInputScreen({super.key, required this.onSubmit});

  static void push(BuildContext context, {required ODPInputResponse onSubmit}) => Navigator.of(
    context,
  ).push<void>(MaterialPageRoute(builder: (context) => ODPInputScreen(onSubmit: onSubmit)));

  final ODPInputResponse onSubmit;

  @override
  State<ODPInputScreen> createState() => _ODPInputScreenState();
}

class _ODPInputScreenState extends State<ODPInputScreen> {
  late final TextEditingController _walletAddressController = TextEditingController();

  Blockchain _selectedNetwork = Blockchain.solana;
  final bool _showNetworkPicker = Blockchain.values.length > 1;

  bool get _isValid => _selectedNetwork.validateAddress(_walletAddressController.text);

  void _handleSubmitted() => widget.onSubmit(_selectedNetwork, _walletAddressController.text);

  void _handleOnNetworkTap() => NetworkPickerScreen.push(
    context,
    initial: _selectedNetwork,
    onSubmitted: (Blockchain network) {
      Navigator.pop(context);
      setState(() => _selectedNetwork = network);
    },
  );

  Future<void> _handleOnQrScan() async {
    final code = await context.launchQrForAddress();

    if (code == null) return;
    if (!mounted) return;

    setState(() {
      _walletAddressController.text = code;
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
        leading: const CpBackButton(),
        title: Text(context.l10n.walletSendToAddressTitle.toUpperCase()),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: OnboardingScreen(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Text(
                context.l10n.selectNetwork,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 8),
            DecoratedBox(
              decoration: const ShapeDecoration(
                color: CpColors.blackGreyColor,
                shape: StadiumBorder(),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                onTap: _showNetworkPicker ? _handleOnNetworkTap : null,
                title: Text(
                  _selectedNetwork.displayName,
                  maxLines: 1,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                trailing:
                    _showNetworkPicker
                        ? const Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: Colors.white,
                          size: 34,
                        )
                        : null,
              ),
            ),
            const SizedBox(height: 36),
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Text(
                context.l10n.walletAddress,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),
            _WalletTextField(controller: _walletAddressController, onQrScan: _handleOnQrScan),
            const Spacer(),
            ListenableBuilder(
              listenable: _walletAddressController,
              builder:
                  (context, child) => CpBottomButton(
                    horizontalPadding: 16,
                    text: context.l10n.next,
                    onPressed: _isValid ? _handleSubmitted : null,
                  ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _WalletTextField extends StatelessWidget {
  const _WalletTextField({required this.controller, required this.onQrScan});

  final TextEditingController controller;
  final VoidCallback onQrScan;

  @override
  Widget build(BuildContext context) => CpTextField(
    controller: controller,
    placeholder: context.l10n.walletAddressFieldHint,
    backgroundColor: CpColors.blackGreyColor,
    padding: const EdgeInsets.only(left: 24, right: 12, top: 20, bottom: 20),
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
    multiLine: true,
  );
}
