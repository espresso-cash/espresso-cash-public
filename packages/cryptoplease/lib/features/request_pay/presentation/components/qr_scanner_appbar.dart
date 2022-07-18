import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class QrScannerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const QrScannerAppBar({
    Key? key,
    required this.onQrScanner,
  }) : super(key: key);

  final VoidCallback onQrScanner;

  @override
  Size get preferredSize => const Size.fromHeight(2 * kToolbarHeight);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: onQrScanner,
                icon: Assets.icons.qrScanner.svg(height: 24),
              ),
            ],
          ),
        ),
      );
}
