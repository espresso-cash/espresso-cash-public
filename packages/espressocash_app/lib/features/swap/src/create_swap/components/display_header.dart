import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/decimal_separator.dart';
import '../../../../../l10n/device_locale.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../ui/number_formatter.dart';

class DisplayHeader extends StatelessWidget {
  const DisplayHeader({
    super.key,
    required this.displayAmount,
  });

  final String displayAmount;

  @override
  Widget build(BuildContext context) {
    final empty = displayAmount.isEmpty;

    if (empty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: FittedBox(
          child: Text(
            context.l10n.enterAmount,
            maxLines: 1,
            style: const TextStyle(
              fontSize: 44,
              fontWeight: FontWeight.w700,
              color: Color(0xff8F8F8F),
            ),
          ),
        ),
      );
    }

    final formatted = displayAmount.formatted(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: FittedBox(
        child: Text(
          formatted,
          maxLines: 1,
          style: const TextStyle(
            fontSize: 80,
            fontWeight: FontWeight.w700,
            height: 1,
          ),
        ),
      ),
    );
  }
}

extension on String {
  String formatted(BuildContext context) {
    final locale = DeviceLocale.localeOf(context);
    final decimalSeparator = getDecimalSeparator(locale);

    if (contains(decimalSeparator)) {
      return this;
    } else if (toDecimalOrZero(locale) == Decimal.zero) {
      return '0';
    }

    return this;
  }
}
