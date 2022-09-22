import 'package:cryptoplease/app/components/info_icon.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/send_flow/fungible_token/confirm_screen/components/amount_fee_view.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
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
            context.l10n.youAreCreatingUniqueLink,
            style: _mediumTextStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          AmountFeeView(
            amount: amount,
            fee: fee,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: CpInfoWidget(
              icon: const InfoIcon(),
              message: Text(context.l10n.sendExplanation),
            ),
          ),
          const Spacer(),
        ],
      );
}

const _mediumTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w500,
);
