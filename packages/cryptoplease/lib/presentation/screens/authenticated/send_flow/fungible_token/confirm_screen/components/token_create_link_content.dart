import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/fungible_token/confirm_screen/components/amount_view.dart';
import 'package:flutter/widgets.dart';

class TokenCreateLinkContent extends StatelessWidget {
  const TokenCreateLinkContent({
    Key? key,
    required this.amount,
    required this.fee,
  }) : super(key: key);

  final Amount amount;
  final Amount fee;

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
          FittedBox(
            child: AmountView.value(
              label: context.l10n.itWillContain,
              amount: amount,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                AmountView.fee(
                  label: context.l10n.labelFee,
                  fee: fee,
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
