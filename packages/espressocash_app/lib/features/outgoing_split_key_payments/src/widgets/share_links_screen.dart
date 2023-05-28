import 'package:flutter/material.dart';

import '../../../../core/amount.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/app_bar.dart';
import '../../../../ui/tab_bar.dart';
import '../../../../ui/theme.dart';
import '../../models/outgoing_split_key_payment.dart';
import 'components/share_link.dart';
import 'components/share_qr.dart';

class ShareLinksScreen extends StatelessWidget {
  const ShareLinksScreen({
    super.key,
    required this.amount,
    required this.status,
  });

  final CryptoAmount amount;
  final OSKPStatusLinksReady status;

  @override
  Widget build(BuildContext context) {
    final title = Text(
      context.l10n.yourLinkIsReady.toUpperCase(),
      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
    );

    final qrLink = status.qrLink;
    final hasQrLink = qrLink != null && qrLink.path != 'null';

    return CpTheme.dark(
      child: Scaffold(
        appBar: CpAppBar(title: title),
        body: SafeArea(
          top: false,
          child: DefaultTabController(
            length: hasQrLink ? 2 : 1,
            child: Column(
              children: [
                if (hasQrLink)
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
                      ShareLinks(status: status, amount: amount),
                      if (hasQrLink)
                        ShareQr(
                          qrLink: qrLink,
                          secondLink: status.link2,
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
