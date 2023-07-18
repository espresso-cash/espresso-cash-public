import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../core/amount.dart';
import '../../../core/currency.dart';
import '../../../core/presentation/format_amount.dart';
import '../../../core/tokens/token.dart';
import '../../../l10n/device_locale.dart';
import 'context_ext.dart';

class TokenRateText extends StatelessWidget {
  const TokenRateText({super.key, required this.token, this.style});

  final Token token;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final locale = DeviceLocale.localeOf(context);

    const fiat = defaultFiatCurrency;
    final Amount? tokenRate = context
        .watchConversionRate(from: token, to: fiat)
        ?.let((it) => Amount.fromDecimal(value: it, currency: fiat));

    return Text(
      tokenRate?.format(locale) ?? '-',
      style: style,
    );
  }
}
