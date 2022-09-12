import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/conversion_rates/presentation/conversion_rates.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/presentation/format_amount.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

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
          child: CpChip(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (formattedFiatAmount != null)
                  FittedBox(
                    child: Text(
                      context.l10n
                          .fiatEquivalent(formattedFiatAmount)
                          .toUpperCase(),
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                if (formattedFiatFee != null)
                  Text(
                    context.l10n.feeAmount(formattedFiatFee),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
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
      formattedAmount = '< $formattedMinimum';
    }

    return formattedAmount;
  }
}

const _minimumAmount = Amount.fiat(value: 1, currency: Currency.usd);
