import 'package:cryptoplease/bl/currency.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/presentation/components/token_fiat_input_widget/token_list_dialog/token_list_dialog.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

class AmountDisplay extends StatelessWidget {
  const AmountDisplay({
    Key? key,
    required this.value,
    required this.currency,
    required this.onTokenChanged,
    required this.availableTokens,
  }) : super(key: key);

  final ValueSetter<Token>? onTokenChanged;
  final Currency currency;
  final String value;
  final IList<Token> availableTokens;

  @override
  Widget build(BuildContext context) {
    final defaultStyle = TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.bold,
      color: CpTheme.of(context).primaryTextColor,
    );

    void _showTokensDialog() => showDialog<void>(
          context: context,
          builder: (_) => TokenListDialog(
            tokens: availableTokens
                .sort((t1, t2) => t1.symbol.compareTo(t2.symbol))
                .toList(),
            onTokenSelected: onTokenChanged ?? (_) {},
          ),
        );

    final textStyle = value.isEmpty
        ? defaultStyle.copyWith(color: defaultStyle.color?.withOpacity(0.35))
        : defaultStyle;

    final shouldShowSelector =
        onTokenChanged != null && availableTokens.length > 1;

    final currencySymbol = Text(currency.symbol, style: textStyle);

    return Container(
      height: 64,
      alignment: Alignment.center,
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // If we are showing the dropdown icon, make the illusion that
            // it is correctly centered
            if (shouldShowSelector)
              const SizedBox(width: _iconSize + _gapSize / 2),

            Text(value.isEmpty ? '0' : value, style: textStyle),
            const SizedBox(width: _gapSize),
            if (shouldShowSelector)
              Material(
                child: Center(
                  child: InkWell(
                    onTap: _showTokensDialog,
                    child: Row(
                      children: [
                        const SizedBox(width: 8),
                        currencySymbol,
                        Icon(
                          Icons.arrow_drop_down,
                          color: textStyle.color,
                          size: _iconSize,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              currencySymbol,
          ],
        ),
      ),
    );
  }
}

const _iconSize = 32.0;
const _gapSize = 8.0;
