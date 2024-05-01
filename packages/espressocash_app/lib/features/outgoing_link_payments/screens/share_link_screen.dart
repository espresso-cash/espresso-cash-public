import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/tab_bar.dart';
import '../../../ui/theme.dart';
import '../../currency/models/amount.dart';
import '../models/outgoing_link_payment.dart';
import '../widgets/share_link.dart';
import '../widgets/share_qr.dart';

class ShareLinkScreen extends StatelessWidget {
  const ShareLinkScreen({
    super.key,
    required this.amount,
    required this.status,
  });

  static void push(
    BuildContext context, {
    required CryptoAmount amount,
    required OLPStatusLinkReady status,
  }) =>
      Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => ShareLinkScreen(amount: amount, status: status),
        ),
      );

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
