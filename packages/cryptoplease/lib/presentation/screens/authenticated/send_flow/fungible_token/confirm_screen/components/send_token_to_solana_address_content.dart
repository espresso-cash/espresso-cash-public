import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/screens/authenticated/profile/component/address_view.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/fungible_token/confirm_screen/components/amount_view.dart';
import 'package:flutter/widgets.dart';

class SendTokenToSolanaAddressContent extends StatelessWidget {
  const SendTokenToSolanaAddressContent({
    Key? key,
    required this.amount,
    required this.fee,
    required this.address,
  }) : super(key: key);

  final Amount amount;
  final Amount fee;
  final String address;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              context.l10n.confirmationTitle,
              style: _largeTextStyle,
            ),
            const SizedBox(height: 40),
            FittedBox(
              child: AmountView.value(
                label: context.l10n.youAreSending,
                amount: amount,
              ),
            ),
            const SizedBox(height: 40),
            Text(context.l10n.to, style: _mediumTextStyle),
            AddressView(
              address: address,
              decorate: false,
              textStyle: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w600,
              ),
              width: null,
            ),
            const SizedBox(height: 40),
            AmountView.fee(
              fee: fee,
              label: context.l10n.labelFee,
            ),
          ],
        ),
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
