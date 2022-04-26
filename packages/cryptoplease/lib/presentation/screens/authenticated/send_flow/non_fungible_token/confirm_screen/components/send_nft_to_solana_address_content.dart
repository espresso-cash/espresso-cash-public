import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/nft_image.dart';
import 'package:cryptoplease/presentation/screens/authenticated/profile/component/address_view.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/fungible_token/confirm_screen/components/amount_view.dart';
import 'package:flutter/widgets.dart';
import 'package:solana/metaplex.dart';

class SendNftToSolanaAddressContent extends StatelessWidget {
  const SendNftToSolanaAddressContent({
    Key? key,
    required this.fee,
    required this.address,
    required this.metadata,
  }) : super(key: key);

  final Amount fee;
  final String address;
  final Metadata metadata;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(context.l10n.confirmationTitle, style: _largeTextStyle),
            const SizedBox(height: 40),
            Text(context.l10n.youAreSending, style: _mediumTextStyle),
            SizedBox(
              height: 244,
              child: Center(child: NftImage(metadata: metadata, size: 184)),
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
