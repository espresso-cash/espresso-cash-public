import 'package:cryptoplease/app/components/number_formatter.dart';
import 'package:cryptoplease/app/ui/chip.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/l10n/decimal_separator.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:flutter/material.dart';

class ODPHeader extends StatelessWidget {
  const ODPHeader({
    Key? key,
    required this.inputController,
    required this.token,
    required this.collapsed,
  }) : super(key: key);

  final TextEditingController inputController;
  final Token token;
  final bool collapsed;

  @override
  Widget build(BuildContext context) =>
      ValueListenableBuilder<TextEditingValue>(
        valueListenable: inputController,
        builder: (context, value, _) => Column(
          children: [
            _InputDisplay(
              input: value.text,
              fontSize: collapsed ? 57 : 80,
            ),
            if (!collapsed)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: _EquivalentDisplay(
                  input: value.text,
                  token: token,
                ),
              )
          ],
        ),
      );
}

class _EquivalentDisplay extends StatelessWidget {
  const _EquivalentDisplay({
    Key? key,
    required this.input,
    required this.token,
  }) : super(key: key);

  final String input;
  final Token token;

  @override
  Widget build(BuildContext context) {
    final locale = DeviceLocale.localeOf(context);
    final value = input.toDecimalOrZero(locale);
    final symbol = token.symbol;
    final shouldDisplay = value.toDouble() != 0;
    final amount = shouldDisplay ? input : '0';
    final formatted = context.l10n.tokenEquivalent(amount, symbol);

    return SizedBox(
      height: 50,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: shouldDisplay ? 1 : 0,
        child: CpChip(
          padding: CpChipPadding.small,
          child: Text(
            formatted.toUpperCase(),
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
}

class _InputDisplay extends StatelessWidget {
  const _InputDisplay({
    Key? key,
    required this.input,
    required this.fontSize,
  }) : super(key: key);

  final String input;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final sign = Currency.usd.sign;
    final amount = input.formatted(context);
    final formatted = '$sign$amount';

    return FittedBox(
      child: Text(
        formatted,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
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
