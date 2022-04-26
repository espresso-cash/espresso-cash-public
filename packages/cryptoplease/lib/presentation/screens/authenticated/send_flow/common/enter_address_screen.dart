import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/bl/qr_scanner/qr_scanner_request.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/decorated_window.dart';
import 'package:cryptoplease/presentation/routes.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:solana/solana.dart';

abstract class RecipientSetter {
  void onRecipientSet(String recipient);
}

class EnterAddressScreen extends StatefulWidget {
  const EnterAddressScreen({
    Key? key,
    required this.initialAddress,
    this.onRecipientSelected,
  }) : super(key: key);

  final String? initialAddress;
  final ValueSetter<String>? onRecipientSelected;

  @override
  State<EnterAddressScreen> createState() => _EnterAddressScreenState();
}

class _EnterAddressScreenState extends State<EnterAddressScreen> {
  final _controller = TextEditingController();
  bool _isAddressValid = false;

  @override
  void initState() {
    super.initState();

    final initialAddress = widget.initialAddress;
    if (initialAddress != null) {
      _controller.text = initialAddress;
      _isAddressValid = isValidAddress(initialAddress);
    }

    _controller.addListener(_onTextChange);
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
  void didUpdateWidget(covariant EnterAddressScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldAddress = oldWidget.initialAddress;
    final currentAddress = widget.initialAddress;
    if (oldAddress != currentAddress && currentAddress != null) {
      _controller.text = currentAddress;
    }
  }

  void _setFromClipboard() {
    Clipboard.getData(Clipboard.kTextPlain).then((ClipboardData? data) {
      if (data != null) {
        _controller.text = data.text ?? '';
      }
    });
  }

  Future<void> _onQrCodeSelected() async {
    final request =
        await context.router.push<QrScannerRequest>(const QrScannerRoute());

    final address = request?.map(
      solanaPay: (r) => r.request.recipient.toBase58(),
      address: (r) => r.address,
    );
    if (address != null) {
      _controller.text = address;
    }
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
          backButton: BackButton(onPressed: () => context.router.pop()),
          bottomButton: CpContentPadding(
            child: CpButton(
              text: context.l10n.next,
              minWidth: double.infinity,
              onPressed: _isAddressValid
                  ? () => context
                      .read<RecipientSetter>()
                      .onRecipientSet(_controller.text)
                  : null,
            ),
          ),
          child: CpContentPadding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _controller,
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
                    hintText: context.l10n.solanaAddressOfTheReceiver,
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
                      onPressed: _onQrCodeSelected,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
}
