import 'package:cryptoplease/bl/accounts/account.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/decorated_window.dart';
import 'package:cryptoplease/presentation/screens/authenticated/profile/component/address_view.dart';
import 'package:cryptoplease/presentation/snackbars.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';

class ShareAddressScreen extends StatelessWidget {
  const ShareAddressScreen({Key? key}) : super(key: key);

  static const double _margin = 24;

  Future<void> _copyAddress(BuildContext context) async {
    final account = context.read<MyAccount>();
    await Clipboard.setData(ClipboardData(text: account.address));
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
      hasAppBarBorder: false,
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
            AddressView(
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
