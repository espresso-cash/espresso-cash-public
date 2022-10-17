import 'package:cryptoplease/app/components/decorated_window.dart';
import 'package:cryptoplease/app/components/snackbars.dart';
import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/ui/button.dart';
import 'package:cryptoplease/ui/colors.dart';
import 'package:cryptoplease/ui/content_padding.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';

class ShareAddressScreen extends StatelessWidget {
  const ShareAddressScreen({Key? key}) : super(key: key);

  static const double _margin = 24;

  void _copyAddress(BuildContext context) {
    final account = context.read<MyAccount>();
    Clipboard.setData(ClipboardData(text: account.address));
    showClipboardSnackbar(context);
  }

  Future<void> _shareAddress(BuildContext context) async {
    final account = context.read<MyAccount>();
    await Share.share(account.address);
  }

  @override
  Widget build(BuildContext context) {
    final account = context.watch<MyAccount>();

    return DecoratedWindow(
      backgroundStyle: BackgroundStyle.light,
      child: CpContentPadding(
        child: Column(
          children: [
            Text(context.l10n.receive.toUpperCase(), style: _largeTextStyle),
            const SizedBox(height: 16),
            Text(context.l10n.hereIsYourSolanaAddress, style: _mediumTextStyle),
            const SizedBox(height: 24),
            SizedBox(
              width: 200,
              height: 200,
              child: QrImage(data: account.address, size: 200),
            ),
            const SizedBox(height: 32),
            _AddressView(
              address: account.address,
              width: MediaQuery.of(context).size.width - _margin,
              textStyle: _mediumTextStyle,
              decorate: false,
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: _margin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CpButton(
                      text: context.l10n.copy,
                      onPressed: () => _copyAddress(context),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CpButton(
                      text: context.l10n.share,
                      onPressed: () => _shareAddress(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const _mediumTextStyle = TextStyle(
  fontSize: 21,
  fontWeight: FontWeight.w600,
);

const _largeTextStyle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.w600,
);

class _AddressView extends StatelessWidget {
  const _AddressView({
    Key? key,
    required this.address,
    this.textStyle,
    this.decorate = true,
    this.width = 150,
  }) : super(key: key);

  final String address;
  final TextStyle? textStyle;
  final double? width;
  final bool decorate;

  void _onTap(BuildContext context) {
    final data = ClipboardData(text: address);
    Clipboard.setData(data);
    showClipboardSnackbar(context);
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => _onTap(context),
        child: Container(
          width: width,
          constraints: const BoxConstraints(minHeight: 32),
          decoration: decorate
              ? const BoxDecoration(
                  color: CpColors.lightGreyBackground,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                )
              : null,
          alignment: Alignment.center,
          child: FittedBox(
            child: Text.rich(
              TextSpan(
                text: '${substring(address, 0, 4)}'
                    '\u2026'
                    '${substring(address, address.length - 4)}',
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Icon(
                        Icons.copy,
                        size: 16,
                        color: textStyle?.color ?? CpColors.primaryTextColor,
                      ),
                    ),
                  ),
                ],
              ),
              style: textStyle ??
                  const TextStyle(
                    color: CpColors.primaryTextColor,
                    fontSize: 18,
                  ),
            ),
          ),
        ),
      );
}
