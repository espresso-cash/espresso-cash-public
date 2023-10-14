import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

import '../../../ui/rounded_rectangle.dart';

class QrWidget extends StatelessWidget {
  const QrWidget({
    super.key,
    required this.qrLink,
  });

  final Uri qrLink;

  @override
  Widget build(BuildContext context) => CpRoundedRectangle(
        scrollable: false,
        padding: const EdgeInsets.all(24),
        backgroundColor: Colors.black,
        child: BarcodeWidget(
          width: 130,
          height: 130,
          barcode: Barcode.qrCode(),
          data: qrLink.toString(),
          padding: EdgeInsets.zero,
          color: Colors.white,
        ),
      );
}
