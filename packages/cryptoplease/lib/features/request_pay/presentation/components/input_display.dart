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
    const defaultValue = Amount.crypto(value: 0, currency: Currency.sol);
    final defaultMask = defaultValue.format(locale, skipSymbol: true);
    final mask = input.differenceMask(locale, defaultMask);

    return FittedBox(
      child: Text.rich(
        TextSpan(
          text: input,
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
  String differenceMask(Locale locale, String defaultMask) {
    var inputValue = this;
    final decimalSeparator = getDecimalSeparator(locale);

    if (inputValue.isEmpty) return defaultMask;
    if (inputValue[0] == decimalSeparator) {
      inputValue = '0$inputValue';
    }

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
