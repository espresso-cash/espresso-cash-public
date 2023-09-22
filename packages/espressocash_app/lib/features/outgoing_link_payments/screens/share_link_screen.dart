import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../core/amount.dart';
import '../../../l10n/l10n.dart';
import '../../../routes.gr.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/tab_bar.dart';
import '../../../ui/theme.dart';
import '../models/outgoing_link_payment.dart';
import '../widgets/share_link.dart';
import '../widgets/share_qr.dart';

@RoutePage()
class ShareLinkScreen extends StatelessWidget {
  const ShareLinkScreen({
    super.key,
    required this.amount,
    required this.status,
  });

  static const route = ShareLinkRoute.new;

  final CryptoAmount amount;
  final OLPStatusLinkReady status;

  @override
  Widget build(BuildContext context) {
    final title = Text(
      context.l10n.yourLinkIsReady.toUpperCase(),
      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
    );

    return CpTheme.dark(
      child: Scaffold(
        appBar: CpAppBar(title: title),
        body: SafeArea(
          top: false,
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(48, 24, 48, 16),
                  child: CpTabBar(
                    variant: CpTabBarVariant.inverted,
                    tabs: [
                      Tab(text: context.l10n.sharePaymentRequestLinkTitle),
                      Tab(text: context.l10n.sharePaymentRequestQrCodeTitle),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
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
