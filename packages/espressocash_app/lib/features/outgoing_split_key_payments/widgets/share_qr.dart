import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/amount.dart';
import '../../../core/presentation/format_amount.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/colors.dart';
import '../../../ui/content_padding.dart';
import '../../../ui/rounded_rectangle.dart';

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
  });

  final String amount;
  final String qrLink;

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
                  // secondLink: secondLink,
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
    required this.height,
  });

  final String qrLink;
  final double height;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => Stack(
          alignment: Alignment.center,
          children: [
            BarcodeWidget(
              height: height,
              barcode: Barcode.qrCode(),
              data: qrLink,
              padding: EdgeInsets.zero,
              color: Colors.white,
            ),
          ],
        ),
      );
}
