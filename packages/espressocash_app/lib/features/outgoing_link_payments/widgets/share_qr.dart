import 'package:barcode_widget/barcode_widget.dart';

import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/rounded_rectangle.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../currency/models/amount.dart';

class ShareQr extends StatelessWidget {
  const ShareQr({
    super.key,
    required this.amount,
    required this.qrLink,
  });

  final CryptoAmount amount;
  final Uri qrLink;

  @override
  Widget build(BuildContext context) {
    final amount = this.amount.formatWithFiat(context);

    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
      // TODO(KB): Check if needed
      // ignore: avoid-single-child-column-or-row
      child: Column(
        children: [
          Flexible(
            child: _QrCodeWrapper(amount: amount, qrData: qrLink.toString()),
          ),
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

  final String amount;
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
          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Text(
              context.l10n.scanToReceive(amount),
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
