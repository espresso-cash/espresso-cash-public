import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/device_locale.dart';
import '../../amount.dart';
import '../../currency.dart';
import '../../presentation/format_amount.dart';
import '../../tokens/token.dart';
import '../../user_preferences.dart';
import '../bl/repository.dart';

class TokenRateText extends StatelessWidget {
  const TokenRateText({super.key, required this.token, this.style});

  final Token token;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final locale = DeviceLocale.localeOf(context);

    final fiatCurrency = context.read<UserPreferences>().fiatCurrency;
    final Amount? tokenRate = context
        .watch<ConversionRatesRepository>()
        .testReadRate(CryptoCurrency(token: token), to: fiatCurrency)
        ?.let((it) => Amount.fromDecimal(value: it, currency: fiatCurrency));
    // final Amount? tokenRate = context
    //     .watchConversionRate(from: token, to: fiatCurrency)
    //     ?.let((it) => Amount.fromDecimal(value: it, currency: fiatCurrency));

    return Text(
      tokenRate?.format(locale) ?? '-',
      style: style,
    );
  }
}
