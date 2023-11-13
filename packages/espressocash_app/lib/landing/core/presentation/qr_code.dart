import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class QrWidget extends StatelessWidget {
  const QrWidget({
    super.key,
    required this.qrLink,
  });

  final Uri qrLink;

  @override
  Widget build(BuildContext context) => BarcodeWidget(
        width: 160,
        height: 160,
        barcode: Barcode.qrCode(),
        data: qrLink.toString(),
        padding: const EdgeInsets.all(8),
        color: Colors.black,
        backgroundColor: const Color(0xFFF8EAC1),
      );
}
