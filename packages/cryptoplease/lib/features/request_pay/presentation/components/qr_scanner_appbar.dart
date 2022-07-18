import 'package:flutter/material.dart';

class QrScannerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const QrScannerAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(2 * kToolbarHeight);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // TODO: onpressed
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.qr_code),
              ),
            ],
          ),
        ),
      );
}
