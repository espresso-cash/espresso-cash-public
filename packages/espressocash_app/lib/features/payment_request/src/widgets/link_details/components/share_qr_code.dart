import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/presentation/format_amount.dart';
import '../../../../../../core/tokens/token_list.dart';
import '../../../../../../di.dart';
import '../../../../../../l10n/l10n.dart';
import '../../../../../../ui/rounded_rectangle.dart';
import '../../../../models/payment_request.dart';

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

    final qrData = paymentRequest.payRequest.toUrl();

    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
      child: Column(
        children: [
          _Subtitle(text: context.l10n.sharePaymentRequestQrCodeDescription),
          _QrCodeWrapper(amount: amount, qrData: qrData),
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

    return Flexible(
      child: CpRoundedRectangle(
        scrollable: false,
        margin: const EdgeInsets.symmetric(vertical: 16),
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
              child: BarcodeWidget(
                barcode: Barcode.qrCode(),
                data: qrData,
                padding: EdgeInsets.zero,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Subtitle extends StatelessWidget {
  const _Subtitle({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
      );
}
