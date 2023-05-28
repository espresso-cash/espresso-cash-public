import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/amount.dart';
import '../../../../../core/presentation/format_amount.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../ui/colors.dart';
import '../../../../../ui/content_padding.dart';
import '../../../../../ui/rounded_rectangle.dart';

class ShareQr extends StatelessWidget {
  const ShareQr({
    super.key,
    required this.amount,
    required this.qrLink,
    required this.secondLink,
  });

  final CryptoAmount amount;
  final Uri qrLink;
  final Uri secondLink;

  @override
  Widget build(BuildContext context) {
    final amount = this.amount.formatWithFiat(context);

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
                qrLink: qrLink.toString(),
                secondLink: secondLink.toString(),
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
                children: [
                  FittedBox(
                    child: Text(
                      context.l10n.qrScanInfo1,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  FittedBox(
                    child: Text(
                      context.l10n.qrScanInfo2,
                      style: const TextStyle(
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
        padding: const EdgeInsets.all(18),
        child: LayoutBuilder(
          builder: (context, constraints) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.l10n.scanToReceive(amount),
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
              dimension: 120,
              child: BarcodeWidget(
                barcode: Barcode.aztec(),
                data: secondLink,
                padding: const EdgeInsets.all(8),
                color: CpColors.darkBackground,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                    color: CpColors.darkBackground,
                    width: 4,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
