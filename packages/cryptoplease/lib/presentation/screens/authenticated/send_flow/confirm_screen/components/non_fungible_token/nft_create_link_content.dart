import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/confirm_screen/components/list_item.dart';
import 'package:flutter/widgets.dart';

class NftCreateLinkContent extends StatelessWidget {
  const NftCreateLinkContent({
    Key? key,
    required this.image,
    required this.fee,
  }) : super(key: key);

  final String image;
  final String fee;

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
                  child: Image.network(image),
                ),
              ),
            ),
          ),
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
