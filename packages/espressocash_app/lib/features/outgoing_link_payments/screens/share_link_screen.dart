import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/share_link.dart';
import '../../../ui/theme.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../currency/models/amount.dart';
import '../models/outgoing_link_payment.dart';

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
