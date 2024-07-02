import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../utils/extensions.dart';
import 'button.dart';
import 'clipboard.dart';

class PartnerOrderIdWidget extends StatelessWidget {
  const PartnerOrderIdWidget({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) => orderId.isEmpty
      ? const SizedBox.shrink()
      : InkWell(
          onTap: () => context.copyToClipboard(orderId),
          child: SizedBox(
            height: CpButtonSize.big.height,
            child: Center(
              child: Text(
                context.l10n.orderId(orderId.toShortAddress()),
                style: const TextStyle(
                  color: Color(0xFF979593),
                  fontSize: 14,
                ),
              ),
            ),
          ),
        );
}
