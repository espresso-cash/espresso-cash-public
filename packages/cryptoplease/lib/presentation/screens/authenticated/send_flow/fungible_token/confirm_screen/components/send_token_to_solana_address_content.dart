import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/screens/authenticated/profile/component/address_view.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/fungible_token/confirm_screen/components/amount_view.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/fungible_token/confirm_screen/components/list_item.dart';
import 'package:flutter/widgets.dart';

class SendTokenToSolanaAddressContent extends StatelessWidget {
  const SendTokenToSolanaAddressContent({
    Key? key,
    required this.amount,
    required this.fee,
    required this.address,
    this.fiatAmount,
  }) : super(key: key);

  final String amount;
  final String fee;
  final String address;
  final String? fiatAmount;

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
            Text(
              context.l10n.youAreSending,
              style: _mediumTextStyle,
            ),
            FittedBox(
              child: AmountView(amount: amount),
            ),
            if (fiatAmount != null)
              Text('≈ $fiatAmount', style: _mediumTextStyle),
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
            ListItem(
              label: context.l10n.labelFee,
              value: fee,
            )
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
