import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/rounded_rectangle.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../tokens/token_list.dart';
import '../models/payment_request.dart';

class ShareQrCode extends StatelessWidget {
  const ShareQrCode({
    super.key,
    required this.paymentRequest,
  });

  final PaymentRequest paymentRequest;

  @override
  Widget build(BuildContext context) {
    final tokenlist = sl<TokenList>();

    final amount = paymentRequest.payRequest
        .cryptoAmount(tokenlist)
        ?.formatWithFiat(context);

    final qrData = paymentRequest.dynamicLink;

    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
      // TODO(KB): Check if needed
      // ignore: avoid-single-child-column-or-row
      child: Column(
        children: [
          Flexible(child: _QrCodeWrapper(amount: amount, qrData: qrData)),
        ],
      ),
    );
  }
}

class _QrCodeWrapper extends StatelessWidget {
  const _QrCodeWrapper({
    required this.amount,
    required this.qrData,
  });

  final String? amount;
  final String qrData;

  @override
  Widget build(BuildContext context) {
    final amount = this.amount;

    return CpRoundedRectangle(
      backgroundColor: Colors.black,
      scrollable: false,
      margin: const EdgeInsets.symmetric(vertical: 24),
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (amount != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Text(
                context.l10n.scanToSend(amount),
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          BarcodeWidget(
            height: 250,
            barcode: Barcode.qrCode(),
            data: qrData,
            padding: EdgeInsets.zero,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
