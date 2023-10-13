import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

import '../../../ui/rounded_rectangle.dart';

class ShareQr extends StatelessWidget {
  const ShareQr({
    super.key,
    required this.qrLink,
  });

  final Uri qrLink;

  @override
  Widget build(BuildContext context) => CpRoundedRectangle(
        scrollable: false,
        padding: const EdgeInsets.all(24),
        child: BarcodeWidget(
          width: 120,
          height: 120,
          barcode: Barcode.qrCode(),
          data: qrLink.toString(),
          padding: EdgeInsets.zero,
          color: Colors.white,
        ),
      );
}
