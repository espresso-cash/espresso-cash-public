import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/amount.dart';
import '../../../../../core/presentation/format_amount.dart';
import '../../../../../gen/assets.gen.dart';
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
    final amount = this.amount.formatWithFiat(context);
    final qrLink = status.qrLink.toString();
    final secondLink = status.link2.toString();

    return CpContentPadding(
      child: CpRoundedRectangle(
        scrollable: false,
        child: Column(
          children: [
            const _QrInfoHeader(),
            const Divider(color: CpColors.darkDividerColor),
            Expanded(
              child: _QrBody(
                amount: amount,
                qrLink: qrLink,
                secondLink: secondLink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QrInfoHeader extends StatelessWidget {
  const _QrInfoHeader();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Assets.icons.qrScanner.svg(height: 26),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  FittedBox(
                    child: Text(
                      'If the recipient has the app installed:',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  FittedBox(
                    child: Text(
                      'They should use the in-app QR scanner.',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

class _QrBody extends StatelessWidget {
  const _QrBody({
    required this.amount,
    required this.qrLink,
    required this.secondLink,
  });

  final String amount;
  final String qrLink;
  final String secondLink;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
        child: LayoutBuilder(
          builder: (context, constraints) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Scan to receive $amount',
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: _CustomQrCode(
                  qrLink: qrLink,
                  secondLink: secondLink,
                  height: constraints.maxWidth,
                ),
              ),
            ],
          ),
        ),
      );
}

class _CustomQrCode extends StatelessWidget {
  const _CustomQrCode({
    required this.qrLink,
    required this.secondLink,
    required this.height,
  });

  final String qrLink;
  final String secondLink;
  final double height;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => Stack(
          alignment: Alignment.center,
          children: [
            BarcodeWidget(
              height: height,
              barcode: Barcode.qrCode(
                errorCorrectLevel: BarcodeQRCorrectionLevel.high,
              ),
              data: qrLink,
              padding: EdgeInsets.zero,
              color: Colors.white,
            ),
            SizedBox.square(
              dimension: 115,
              child: BarcodeWidget(
                barcode: Barcode.aztec(),
                data: secondLink,
                padding: const EdgeInsets.all(12),
                color: CpColors.primaryColor,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                    color: CpColors.primaryColor,
                    width: 6,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
