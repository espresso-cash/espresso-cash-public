import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../l10n/l10n.dart';
import 'button.dart';
import 'rounded_rectangle.dart';

class ShareCodeWidget extends StatelessWidget {
  const ShareCodeWidget({
    super.key,
    required this.title,
    required this.amount,
    required this.qrCode,
    required this.shareText,
  });

  final String title;
  final String amount;
  final String qrCode;
  final String shareText;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(24),
        child: CpRoundedRectangle(
          backgroundColor: Colors.black,
          scrollable: false,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 35),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const TextSpan(text: '\n'),
                    TextSpan(
                      text: amount,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: BarcodeWidget(
                  height: 250,
                  barcode: Barcode.qrCode(),
                  data: qrCode,
                  padding: EdgeInsets.zero,
                  color: Colors.white,
                ),
              ),
              CpButton(
                text: context.l10n.share,
                width: double.infinity,
                size: CpButtonSize.big,
                onPressed: () => Share.share(shareText),
              ),
            ],
          ),
        ),
      );
}
