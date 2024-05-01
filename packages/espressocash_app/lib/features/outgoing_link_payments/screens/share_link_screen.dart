import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:share/share.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/button.dart';
import '../../../ui/rounded_rectangle.dart';
import '../../../ui/theme.dart';
import '../../authenticated/authenticated_navigator_key.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../currency/models/amount.dart';
import '../models/outgoing_link_payment.dart';

class ShareLinkScreen extends StatelessWidget {
  const ShareLinkScreen({
    super.key,
    required this.amount,
    required this.status,
  });

  final CryptoAmount amount;
  final OLPStatusLinkReady status;

  @override
  Widget build(BuildContext context) {
    final title = Text(
      context.l10n.pay.toUpperCase(),
      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
    );

    final formattedAmount = amount.formatWithFiat(context);

    final message = context.l10n.shareText(
      formattedAmount,
      status.link,
    );

    return CpTheme.black(
      child: Scaffold(
        appBar: CpAppBar(title: title),
        body: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: CpRoundedRectangle(
              backgroundColor: Colors.black,
              scrollable: false,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.l10n.scanToReceive(formattedAmount),
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40.0),
                    child: BarcodeWidget(
                      height: 250,
                      barcode: Barcode.qrCode(),
                      data: status.link.toString(),
                      padding: EdgeInsets.zero,
                      color: Colors.white,
                    ),
                  ),
                  CpButton(
                    text: context.l10n.share,
                    width: double.infinity,
                    size: CpButtonSize.big,
                    onPressed: () => Share.share(message),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ShareLinkRoute extends GoRouteData {
  const ShareLinkRoute(this.$extra);

  final ShareLinkParams $extra;

  static final GlobalKey<NavigatorState> $parentNavigatorKey =
      authenticatedNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ShareLinkScreen(amount: $extra.amount, status: $extra.status);
}

typedef ShareLinkParams = ({
  CryptoAmount amount,
  OLPStatusLinkReady status,
});
