import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/bl/currency.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/presentation/conversion_rates.dart';
import 'package:cryptoplease/presentation/format_amount.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

class CryptoAmountView extends StatelessWidget {
  const CryptoAmountView({
    Key? key,
    required this.token,
    required this.amount,
  }) : super(key: key);

  final Token token;
  final FiatAmount amount;

  @override
  Widget build(BuildContext context) {
    final rate = context.watchConversionRate(from: token, to: amount.currency);
    if (rate == null) return const SizedBox();

    // TODO(KB): Extract conversion to BL
    final formatted = amount
        .convert(
          rate: rate.inverse.toDecimal(
            scaleOnInfinitePrecision: token.decimals,
          ),
          to: Currency.crypto(token: token),
        )
        .format(DeviceLocale.localeOf(context));

    return Text(
      '≈ $formatted',
      maxLines: 1,
      style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: 21),
    );
  }
}
