import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/share_link.dart';
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
          child: ShareCodeWidget(
            title: context.l10n.scanToReceive,
            amount: formattedAmount,
            qrCode: status.link.toString(),
            shareText: message,
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
