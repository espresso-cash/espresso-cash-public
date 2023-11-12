import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../l10n/l10n.dart';
import '../../../../ui/button.dart';
import '../../../../ui/rounded_rectangle.dart';
import '../../../../ui/snackbar.dart';

class DestinationAddressWidget extends StatelessWidget {
  const DestinationAddressWidget({
    super.key,
    required this.address,
  });

  final String address;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 410,
        height: 155,
        child: CpRoundedRectangle(
          padding: const EdgeInsets.all(24),
          backgroundColor: Colors.black,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: BarcodeWidget(
                  width: 100,
                  height: 100,
                  barcode: Barcode.qrCode(),
                  data: address,
                  padding: EdgeInsets.zero,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      address,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CpButton(
                        text: context.l10n.copy,
                        minWidth: 80,
                        onPressed: () {
                          final data = ClipboardData(text: address);
                          Clipboard.setData(data);
                          showClipboardSnackbar(context);
                        },
                        size: CpButtonSize.micro,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
