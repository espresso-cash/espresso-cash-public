import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/clipboard.dart';
import '../../../utils/extensions.dart';

class InvoiceTextWidget extends StatelessWidget {
  const InvoiceTextWidget({super.key, required this.reference});

  final String reference;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => context.copyToClipboard(reference),
        child: Center(
          child: Text(
            context.l10n.invoiceNumber(reference.toShortAddress()),
            style: const TextStyle(
              color: Color(0xFF929292),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      );
}
