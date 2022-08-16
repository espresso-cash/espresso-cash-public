import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/conversion_rates/presentation/conversion_rates.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/presentation/format_amount.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

// TODO(rhbrunetto): add copies to arb, move _CpChip to ui lib, create CpInfoWidget and CpChip variants
class AmountFeeView extends StatelessWidget {
  const AmountFeeView({
    Key? key,
    required this.amount,
    required this.fee,
  }) : super(key: key);

  final Amount amount;
  final Amount fee;

  @override
  Widget build(BuildContext context) {
    final fiatAmount = amount.map(
      crypto: (crypto) => context.convertToFiat(
        fiatCurrency: Currency.usd,
        token: crypto.token,
        amount: crypto.value,
      ),
      fiat: identity,
    );

    final fiatFee = fee.map(
      crypto: (crypto) => context.convertToFiat(
        fiatCurrency: Currency.usd,
        token: crypto.token,
        amount: crypto.value,
      ),
      fiat: identity,
    );

    final locale = DeviceLocale.localeOf(context);
    final formattedAmount = amount.format(locale);
    final formattedFiatAmount = fiatAmount.formatMinimum(locale);
    final formattedFiatFee = fiatFee.formatMinimum(locale);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FittedBox(
          child: Text(
            formattedAmount,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 55,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 24),
          child: _CpChip(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Equivalent to $formattedFiatAmount'),
                Text('(Fee: $formattedFiatFee)'),
              ],
            ),
          ),
        )
      ],
    );
  }
}

extension on Amount? {
  String? formatMinimum(Locale locale) {
    final amount = this;
    var formattedAmount = amount?.format(locale);

    if (amount != null && amount < _minimumAmount) {
      final formattedMinimum = _minimumAmount.format(locale);
      formattedAmount = '\n< $formattedMinimum';
    }

    return formattedAmount;
  }
}

const _minimumAmount = Amount.fiat(value: 1, currency: Currency.usd);

class _CpChip extends StatelessWidget {
  const _CpChip({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: const ShapeDecoration(
          color: CpColors.darkBackground,
          shape: StadiumBorder(),
        ),
        child: Center(
          widthFactor: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 8),
            child: child,
          ),
        ),
      );
}
