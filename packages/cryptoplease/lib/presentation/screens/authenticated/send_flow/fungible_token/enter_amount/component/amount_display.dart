import 'package:cryptoplease/bl/balances/balances_bloc.dart';
import 'package:cryptoplease/bl/currency.dart';
import 'package:cryptoplease/bl/outgoing_transfers/create_outgoing_transfer_bloc/token/bloc.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/fungible_token/enter_amount/component/token_list_dialog/token_list_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AmountDisplay extends StatelessWidget {
  const AmountDisplay({
    Key? key,
    required this.value,
    required this.currency,
    required this.onTokenChanged,
    this.style,
  }) : super(key: key);

  final ValueSetter<Token>? onTokenChanged;
  final Currency currency;
  final String value;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<BalancesBloc, BalancesState>(
        builder: (context, state) {
          final availableTokens = context
              .watch<FtCreateOutgoingTransferBloc>()
              .state
              .availableTokens
              .toList(growable: false);

          final defaultStyle = Theme.of(context).textTheme.headline2?.copyWith(
                fontSize: 45,
              );
          final disabledStyle = defaultStyle?.copyWith(
            color: defaultStyle.color?.withOpacity(0.35),
            fontSize: 45,
          );

          final onTokenChanged = this.onTokenChanged;

          void _showTokensDialog() {
            final content = TokenListDialog(
              tokens: availableTokens
                ..sort((t1, t2) => t1.symbol.compareTo(t2.symbol)),
              onTokenSelected: onTokenChanged ?? (_) {},
            );

            showDialog<void>(context: context, builder: (_) => content);
          }

          final textStyle =
              style ?? (value.isEmpty ? disabledStyle : defaultStyle);

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
                                color: textStyle?.color,
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
        },
      );
}

const _iconSize = 32.0;
const _gapSize = 8.0;
