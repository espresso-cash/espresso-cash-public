import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../../../l10n/l10n.dart';
import '../../../../../../ui/rounded_rectangle.dart';

class ShareQrCode extends StatelessWidget {
  const ShareQrCode({
    Key? key,
    required this.amount,
    required this.link,
  }) : super(key: key);

  final String? amount;
  final String link;

  @override
  Widget build(BuildContext context) {
    final amount = this.amount;

    return Column(
      children: [
        _Subtitle(
          text: context.l10n.sharePaymentRequestQrCodeDescription,
        ),
        Flexible(
          child: SizedBox(
            child: CpRoundedRectangle(
              scrollable: true,
              margin: const EdgeInsets.symmetric(vertical: 24),
              padding: const EdgeInsets.all(32),
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
                  QrImage(
                    data: link,
                    size: 220,
                    padding: EdgeInsets.zero,
                    foregroundColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Subtitle extends StatelessWidget {
  const _Subtitle({Key? key, required this.text}) : super(key: key);

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
