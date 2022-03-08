import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/fungible_token/confirm_screen/components/amount_view.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/fungible_token/confirm_screen/components/list_item.dart';
import 'package:flutter/widgets.dart';

class TokenCreateLinkContent extends StatelessWidget {
  const TokenCreateLinkContent({
    Key? key,
    required this.amount,
    required this.fee,
    this.fiatAmount,
  }) : super(key: key);

  final String amount;
  final String fee;
  final String? fiatAmount;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(
            context.l10n.confirmationTitle,
            style: _largeTextStyle,
          ),
          const SizedBox(height: 20),
          Text(
            context.l10n.youAreCreatingUniqueLink,
            style: _mediumTextStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Text(
            context.l10n.itWillContain,
            style: _mediumTextStyle,
          ),
          FittedBox(
            child: AmountView(amount: amount),
          ),
          if (fiatAmount != null)
            Text('≈ $fiatAmount', style: _mediumTextStyle),
          Expanded(
            child: ListView(
              children: [
                ListItem(
                  label: context.l10n.labelFee,
                  value: fee,
                ),
              ],
            ),
          ),
        ],
      );
}

const _mediumTextStyle = TextStyle(
  fontSize: 21,
  fontWeight: FontWeight.w600,
);

const _largeTextStyle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.w600,
);
