import 'package:cryptoplease/app/components/number_formatter.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/l10n/decimal_separator.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InputDisplay extends StatelessWidget {
  const InputDisplay({
    Key? key,
    required this.input,
  }) : super(key: key);

  final String input;

  @override
  Widget build(BuildContext context) {
    final sign = Currency.usd.sign;
    final amount = input.formatted(context);
    final formatted = '$sign$amount';

    return FittedBox(
      child: Text(
        formatted,
        textAlign: TextAlign.right,
        style: const TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.bold,
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
