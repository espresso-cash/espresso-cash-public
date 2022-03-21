import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/screens/authenticated/profile/component/address_view.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/fungible_token/confirm_screen/components/list_item.dart';
import 'package:flutter/widgets.dart';

class SendNftToSolanaAddressContent extends StatelessWidget {
  const SendNftToSolanaAddressContent({
    Key? key,
    required this.image,
    required this.fee,
    required this.address,
  }) : super(key: key);

  final String? image;
  final String fee;
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
            Text(
              context.l10n.youAreSending,
              style: _mediumTextStyle,
            ),
            SizedBox(
              height: 244,
              child: Center(
                child: SizedBox(
                  width: 184,
                  height: 184,
                  child: ClipRRect(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16),
                    ),
                    child: image == null
                        ? const SizedBox.shrink()
                        : Image.network(image!),
                  ),
                ),
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
