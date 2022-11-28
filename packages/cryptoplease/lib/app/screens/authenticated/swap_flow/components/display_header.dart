import 'package:flutter/material.dart';

import '../../../../../l10n/decimal_separator.dart';
import '../../../../../l10n/device_locale.dart';
import '../../../../../ui/number_formatter.dart';

class DisplayHeader extends StatelessWidget {
  const DisplayHeader({
    Key? key,
    required this.displayAmount,
  }) : super(key: key);

  final String displayAmount;

  @override
  Widget build(BuildContext context) {
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
    final value = toDecimalOrZero(locale);

    if (contains(decimalSeparator)) {
      return this;
    } else if (value.toDouble() == 0) {
      return '0';
    }

    return this;
  }
}
