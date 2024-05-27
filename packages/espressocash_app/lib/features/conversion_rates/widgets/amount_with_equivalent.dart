import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../l10n/decimal_separator.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/chip.dart';
import '../../../ui/colors.dart';
import '../../../ui/number_formatter.dart';
import '../../../ui/shake.dart';
import '../../../ui/size.dart';
import '../../../ui/usdc_info.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../tokens/token.dart';
import '../services/amount_ext.dart';
import '../services/watch_user_fiat_balance.dart';
import 'extensions.dart';

class AmountWithEquivalent extends StatelessWidget {
  const AmountWithEquivalent({
    super.key,
    required this.inputController,
    required this.collapsed,
    required this.token,
    this.shakeKey,
    this.error = '',
    this.showUsdcInfo = false,
  });

  final TextEditingController inputController;
  final Token token;
  final bool collapsed;
  final Key? shakeKey;
  final String error;
  final bool showUsdcInfo;

  @override
  Widget build(BuildContext context) =>
      ValueListenableBuilder<TextEditingValue>(
        valueListenable: inputController,
        builder: (context, value, _) {
          final num =
              value.text.toDecimalOrZero(DeviceLocale.localeOf(context));

          final isZero = num.toDouble() == 0;
          final hasError = error.isNotEmpty;

          final state = (isZero, hasError, showUsdcInfo);

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.start,
                  children: [
                    Shake(
                      key: shakeKey,
                      child: _InputDisplay(
                        input: value.text,
                        fontSize: collapsed ? 57 : (context.isSmall ? 55 : 80),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _MaxInputChip(
                      inputController: inputController,
                      token: token,
                    ),
                  ],
                ),
              ),
              if (!collapsed)
                Container(
                  height: showUsdcInfo ? (context.isSmall ? 90 : 105) : null,
                  padding: EdgeInsets.only(top: context.isSmall ? 2 : 16),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 100),
                    // TODO(KB): Check if needed
                    // ignore: avoid-single-child-column-or-row
                    child: Column(
                      children: [
                        switch (state) {
                          (_, true, _) => _DisplayChip(
                              key: ValueKey(error),
                              value: error,
                              shouldDisplay: true,
                              backgroundColor: CpColors.errorChipColor,
                            ),
                          (true, false, true) => const _InfoChip(),
                          _ => _EquivalentDisplay(
                              input: value.text,
                              token: token,
                              backgroundColor: Colors.black,
                            ),
                        },
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      );
}

class _MaxInputChip extends StatelessWidget {
  const _MaxInputChip({
    super.key,
    required this.inputController,
    required this.token,
  });
  final TextEditingController inputController;
  final Token token;

  Future<void> onTap(BuildContext context) async {
    inputController.text = Amount.fromDecimal(
            value: sl<WatchUserFiatBalance>().call().$2.decimal,
            currency: Currency.usd)
        .let((it) => it as FiatAmount)
        .let(
          (it) => it.toTokenAmount(token)?.round(Currency.usd.decimals),
        )
        .maybeFlatMap(
          (it) => it.format(
            DeviceLocale.localeOf(context),
            roundInteger: true,
            skipSymbol: true,
          ),
        )
        .ifNull(() => '0');
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => onTap(context),
        child: const Chip(
          padding: EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 10.0,
          ),
          backgroundColor: CpColors.darkBackgroundColor,
          label: Text(
            'Max',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
}

class _InfoChip extends StatelessWidget {
  const _InfoChip();

  @override
  Widget build(BuildContext context) =>
      UsdcInfoWidget(isSmall: context.isSmall);
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
          .let((it) => it.toTokenAmount(token)?.round(Currency.usd.decimals))
          .maybeFlatMap(
            (it) => it.format(locale, roundInteger: true, skipSymbol: true),
          )
          .ifNull(() => '0');
    } else {
      formattedAmount = '0';
    }

    final child = Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: context.l10n.tokenEquivalent(formattedAmount).toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(
            text: ' ${token.symbol.toUpperCase()}',
            style: const TextStyle(
              color: CpColors.yellowColor,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );

    return _Chip(
      shouldDisplay: shouldDisplay,
      backgroundColor: backgroundColor,
      child: child,
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
  Widget build(BuildContext context) => _Chip(
        shouldDisplay: shouldDisplay,
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
      );
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.shouldDisplay,
    required this.child,
    this.backgroundColor,
  });

  final bool shouldDisplay;
  final Widget child;
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
            child: child,
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

    return SizedBox(
      height: 94,
      child: FittedBox(
        fit: BoxFit.scaleDown,
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
