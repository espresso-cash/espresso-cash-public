import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/amount.dart';
import '../../../../core/presentation/format_amount.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/app_bar.dart';
import '../../../../ui/content_padding.dart';
import '../../../../ui/rounded_rectangle.dart';
import '../../../../ui/theme.dart';
import '../bl/outgoing_tip_payment.dart';

class ShareQRScreen extends StatelessWidget {
  const ShareQRScreen({
    Key? key,
    required this.amount,
    required this.status,
  }) : super(key: key);

  final CryptoAmount amount;
  final OTLinkReady status;

  @override
  Widget build(BuildContext context) {
    final formattedAmount = amount.formatWithFiat(context);

    final title = Text(
      context.l10n.tip.toUpperCase(),
      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
    );

    final subtitle = Text(
      context.l10n.tipPaymentSubtitle,
      textAlign: TextAlign.center,
      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
    );

    return CpTheme.dark(
      child: Scaffold(
        appBar: CpAppBar(title: title),
        body: CpContentPadding(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: subtitle,
              ),
              _QrCodeWrapper(
                amount: formattedAmount,
                qrData: status.link.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QrCodeWrapper extends StatelessWidget {
  const _QrCodeWrapper({
    Key? key,
    required this.amount,
    required this.qrData,
  }) : super(key: key);

  final String? amount;
  final String qrData;

  @override
  Widget build(BuildContext context) {
    final amount = this.amount;

    return Flexible(
      child: CpContentPadding(
        child: CpRoundedRectangle(
          scrollable: false,
          margin: const EdgeInsets.symmetric(vertical: 24),
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 42),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (amount != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Text(
                    amount,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              Flexible(
                child: QrImage(
                  data: qrData,
                  padding: EdgeInsets.zero,
                  foregroundColor: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
