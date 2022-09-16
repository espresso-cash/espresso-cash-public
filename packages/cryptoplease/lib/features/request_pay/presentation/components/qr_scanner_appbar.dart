import 'package:cryptoplease/core/tokens/token.dart';
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
          padding: const EdgeInsets.only(
            left: 16,
            top: 8,
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

class AddressAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AddressAppBar({
    Key? key,
    required this.onClose,
    required this.address,
    required this.token,
  }) : super(key: key);

  final VoidCallback onClose;
  final String address;
  final Token token;

  @override
  Size get preferredSize => const Size.fromHeight(3 * kToolbarHeight);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            top: 8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: onClose,
                icon: Assets.icons.close.svg(height: 24),
              ),
              Text('To: $address'),
              Text('Send as: ${token.symbol}'),
            ],
          ),
        ),
      );
}
