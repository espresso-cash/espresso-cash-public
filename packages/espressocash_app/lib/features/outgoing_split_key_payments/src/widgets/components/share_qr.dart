import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/amount.dart';
import '../../../../../core/presentation/format_amount.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../ui/colors.dart';
import '../../../../../ui/content_padding.dart';
import '../../../../../ui/rounded_rectangle.dart';
import '../../../models/outgoing_split_key_payment.dart';

class ShareQr extends StatelessWidget {
  const ShareQr({
    super.key,
    required this.status,
    required this.amount,
  });

  final CryptoAmount amount;
  final OSKPStatusLinksReady status;

  @override
  Widget build(BuildContext context) {
    final subtitle = Text(
      context.l10n.qrPaymentSubtitle,
      textAlign: TextAlign.center,
      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: subtitle,
        ),
        _QrCodeWrapper(
          amount: amount.formatWithFiat(context),
          firstLink: status.link1.toString(),
          secondLink: status.link2.toString(),
        ),
      ],
    );
  }
}

class _QrCodeWrapper extends StatelessWidget {
  const _QrCodeWrapper({
    Key? key,
    required this.amount,
    required this.firstLink,
    required this.secondLink,
  }) : super(key: key);

  final String? amount;
  final String firstLink;
  final String secondLink;

  @override
  Widget build(BuildContext context) {
    final amount = this.amount;

    return Flexible(
      child: CpContentPadding(
        child: CpRoundedRectangle(
          scrollable: false,
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
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
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    BarcodeWidget(
                      barcode: Barcode.qrCode(
                        errorCorrectLevel: BarcodeQRCorrectionLevel.high,
                      ),
                      data: firstLink,
                      padding: EdgeInsets.zero,
                      color: Colors.white,
                    ),
                    // const SizedBox(height: 12),
                    SizedBox.square(
                      dimension: 145,
                      child: BarcodeWidget(
                        barcode: Barcode.aztec(),
                        data: secondLink,
                        padding: const EdgeInsets.all(8),
                        color: CpColors.primaryColor,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          border: Border.all(
                            color: CpColors.primaryColor,
                            // color: Colors.red.shade900,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
