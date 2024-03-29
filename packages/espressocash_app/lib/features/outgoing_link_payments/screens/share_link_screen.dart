import 'package:espressocash_common/espressocash_common.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/tab_bar.dart';
import '../../../ui/theme.dart';
import '../../authenticated/authenticated_navigator_key.dart';
import '../models/outgoing_link_payment.dart';
import '../widgets/share_link.dart';
import '../widgets/share_qr.dart';

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
      context.l10n.yourLinkIsReady.toUpperCase(),
      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
    );

    return CpTheme.black(
      child: Scaffold(
        appBar: CpAppBar(title: title),
        body: SafeArea(
          top: false,
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                  child: CpTabBar(
                    variant: CpTabBarVariant.black,
                    tabs: [
                      Tab(text: context.l10n.sharePaymentRequestLinkTitle),
                      Tab(text: context.l10n.sharePaymentRequestQrCodeTitle),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      ShareLink(status: status, amount: amount),
                      ShareQr(
                        qrLink: status.link,
                        amount: amount,
                      ),
                    ],
                  ),
                ),
              ],
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
