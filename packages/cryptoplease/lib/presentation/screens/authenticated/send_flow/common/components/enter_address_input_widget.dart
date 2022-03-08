import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/decorated_window.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EnterAddressInputWidget extends StatelessWidget {
  const EnterAddressInputWidget({
    Key? key,
    required this.inputLabel,
    required this.inputPlaceholder,
    required this.controller,
    this.onRecipientSelected,
    this.onQrCodeSelected,
  }) : super(key: key);

  final String inputLabel;
  final String inputPlaceholder;
  final TextEditingController controller;
  final VoidCallback? onRecipientSelected;
  final VoidCallback? onQrCodeSelected;

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
                      onPressed: onQrCodeSelected,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
}
