import 'package:cryptoplease/app/ui/theme.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:flutter/material.dart';

class AmountDisplay extends StatelessWidget {
  const AmountDisplay({
    Key? key,
    required this.value,
    required this.currency,
  }) : super(key: key);

  final Currency currency;
  final String value;

  @override
  Widget build(BuildContext context) {
    final defaultStyle = TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.bold,
      color: CpTheme.of(context).primaryTextColor,
    );

    final textStyle = value.isEmpty
        ? defaultStyle.copyWith(color: defaultStyle.color?.withOpacity(0.35))
        : defaultStyle;

    final currencySymbol = Text(currency.symbol, style: textStyle);

    return Container(
      height: 64,
      alignment: Alignment.center,
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(value.isEmpty ? '0' : value, style: textStyle),
            const SizedBox(width: _gapSize),
            currencySymbol,
          ],
        ),
      ),
    );
  }
}

const _gapSize = 8.0;
