import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/nft_image.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/fungible_token/confirm_screen/components/fee_view.dart';
import 'package:flutter/widgets.dart';
import 'package:solana/metaplex.dart';

class NftCreateLinkContent extends StatelessWidget {
  const NftCreateLinkContent({
    Key? key,
    required this.fee,
    required this.fiatFee,
    required this.metadata,
  }) : super(key: key);

  final String fee;
  final String? fiatFee;
  final Metadata metadata;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(context.l10n.confirmationTitle, style: _largeTextStyle),
          const SizedBox(height: 20),
          Text(
            context.l10n.youAreCreatingUniqueLink,
            style: _mediumTextStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Text(context.l10n.itWillContain, style: _mediumTextStyle),
          SizedBox(
            height: 244,
            child: Center(child: NftImage(metadata: metadata, size: 184)),
          ),
          Expanded(
            child: ListView(
              children: [
                FeeView(
                  formattedFee: fee,
                  formattedFiatFee: fiatFee,
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
