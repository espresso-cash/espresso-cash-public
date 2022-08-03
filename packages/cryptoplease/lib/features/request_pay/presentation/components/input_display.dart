import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/presentation/format_amount.dart';
import 'package:cryptoplease/l10n/decimal_separator.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
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
    final locale = DeviceLocale.localeOf(context);
    final decimalSeparator = getDecimalSeparator(locale);
    const defaultValue = Amount.crypto(value: 0, currency: Currency.sol);
    final defaultMask = defaultValue.format(locale, skipSymbol: true);
    final sanitizedInput = input.sanitize(decimalSeparator);
    final mask = sanitizedInput.differenceMask(decimalSeparator, defaultMask);

    return FittedBox(
      child: Text.rich(
        TextSpan(
          text: sanitizedInput,
          children: [
            TextSpan(
              text: mask,
              style: TextStyle(
                color: CpTheme.of(context).primaryTextColor.withOpacity(0.3),
              ),
            ),
          ],
        ),
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
  String sanitize(String decimalSeparator) {
    if (isNotEmpty && this[0] == decimalSeparator) return '0$decimalSeparator';

    return this;
  }

  String differenceMask(String decimalSeparator, String defaultMask) {
    final inputValue = this;

    if (inputValue.isEmpty) return defaultMask;

    final values = inputValue.split(decimalSeparator);
    final hasDecimal = values.length > 1;
    final decimalsWithComma = defaultMask.split(decimalSeparator).last;

    if (hasDecimal) {
      final decimals = values.last.length;
      if (decimals >= decimalsWithComma.length) return '';

      return decimalsWithComma.substring(decimals);
    } else {
      return '$decimalSeparator$decimalsWithComma';
    }
  }
}
