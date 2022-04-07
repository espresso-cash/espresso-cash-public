import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/decorated_window.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solana/solana.dart';

class EnterAddressInputWidget extends StatefulWidget {
  const EnterAddressInputWidget({
    Key? key,
    required this.initialAddress,
    required this.inputLabel,
    required this.inputPlaceholder,
    this.onRecipientSelected,
    this.onQrCodeSelected,
  }) : super(key: key);

  final String? initialAddress;
  final String inputLabel;
  final String inputPlaceholder;
  final ValueSetter<String>? onRecipientSelected;
  final VoidCallback? onQrCodeSelected;

  @override
  State<EnterAddressInputWidget> createState() =>
      _EnterAddressInputWidgetState();
}

class _EnterAddressInputWidgetState extends State<EnterAddressInputWidget> {
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
  void didUpdateWidget(covariant EnterAddressInputWidget oldWidget) {
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
              onPressed: _isAddressValid
                  ? () => widget.onRecipientSelected?.call(_controller.text)
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
                    hintText: widget.inputLabel,
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
                      onPressed: widget.onQrCodeSelected,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
}
