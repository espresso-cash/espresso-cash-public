import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/amount.dart';
import '../core/conversion_rates/amount_ext.dart';
import '../core/conversion_rates/bl/repository.dart';
import '../core/currency.dart';
import '../core/presentation/format_amount.dart';
import '../core/tokens/token.dart';
import '../l10n/decimal_separator.dart';
import '../l10n/device_locale.dart';
import '../l10n/l10n.dart';
import 'chip.dart';
import 'colors.dart';
import 'number_formatter.dart';
import 'shake.dart';

class AmountWithEquivalent extends StatelessWidget {
  const AmountWithEquivalent({
    super.key,
    required this.inputController,
    required this.collapsed,
    required this.token,
    this.shakeKey,
    this.error = '',
  });

  final TextEditingController inputController;
  final Token token;
  final bool collapsed;
  final Key? shakeKey;
  final String error;

  @override
  Widget build(BuildContext context) =>
      ValueListenableBuilder<TextEditingValue>(
        valueListenable: inputController,
        builder: (context, value, _) => Column(
          children: [
            Shake(
              key: shakeKey,
              child: _InputDisplay(
                input: value.text,
                fontSize: collapsed ? 57 : 80,
              ),
            ),
            if (!collapsed)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: error.isNotEmpty
                      ? _DisplayChip(
                          key: ValueKey(error),
                          value: error,
                          shouldDisplay: true,
                          backgroundColor: CpColors.errorChipColor,
                        )
                      : _EquivalentDisplay(
                          input: value.text,
                          token: token,
                          backgroundColor: CpColors.backgroundAccentColor,
                        ),
                ),
              )
          ],
        ),
      );
}

class _EquivalentDisplay extends StatelessWidget {
  const _EquivalentDisplay({
    required this.input,
    required this.token,
    this.backgroundColor,
  });

  final String input;
  final Token token;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final locale = DeviceLocale.localeOf(context);
    final value = input.toDecimalOrZero(locale);
    final shouldDisplay = value.toDouble() != 0;

    final String formattedAmount;
    if (shouldDisplay) {
      formattedAmount = Amount.fromDecimal(value: value, currency: Currency.usd)
          .let((it) => it as FiatAmount)
          .let(
            (it) => it.toTokenAmount(
              token,
              ratesRepository: context.read<ConversionRatesRepository>(),
            ),
          )
          .maybeFlatMap(
            (it) => it.format(
              locale,
              roundInteger: true,
              skipSymbol: true,
              maxDecimals: Currency.usd.decimals,
            ),
          )
          .ifNull(() => '0');
    } else {
      formattedAmount = '0';
    }

    return _DisplayChip(
      shouldDisplay: shouldDisplay,
      value: context.l10n.tokenEquivalent(formattedAmount, token.symbol),
      backgroundColor: backgroundColor,
    );
  }
}

class _DisplayChip extends StatelessWidget {
  const _DisplayChip({
    super.key,
    required this.shouldDisplay,
    required this.value,
    this.backgroundColor,
  });

  final bool shouldDisplay;
  final String value;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 45,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: shouldDisplay ? 1 : 0,
          child: CpChip(
            padding: CpChipPadding.small,
            backgroundColor: backgroundColor,
            child: Text(
              value.toUpperCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
}

class _InputDisplay extends StatelessWidget {
  const _InputDisplay({
    required this.input,
    required this.fontSize,
  });

  final String input;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final sign = Currency.usd.sign;
    final amount = input.formatted(context);
    final formatted = '$sign$amount';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: FittedBox(
        child: Text(
          formatted,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
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
