import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class QrWidget extends StatelessWidget {
  const QrWidget({
    super.key,
    required this.code,
    this.size = 160,
  });

  final String code;
  final double size;

  @override
  Widget build(BuildContext context) => BarcodeWidget(
        width: size,
        height: size,
        barcode: Barcode.qrCode(),
        data: code,
        padding: const EdgeInsets.all(8),
        color: Colors.black,
        backgroundColor: const Color(0xFFF8EAC1),
      );
}
