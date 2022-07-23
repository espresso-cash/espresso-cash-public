import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class MenuHeader extends StatelessWidget {
  const MenuHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CpAppBar(
            hasBorder: false,
            automaticallyImplyLeading: false,
            title: SizedBox(
              height: kToolbarHeight,
              child: Stack(
                children: [
                  Center(
                    child: Assets.images.logoDark.image(height: 32),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const ShapeDecoration(
                        shape: CircleBorder(),
                        color: CpColors.greyIconBackgroundColor,
                      ),
                      child: IconButton(
                        iconSize: 16,
                        icon: const Icon(
                          Icons.settings,
                          color: CpColors.darkBackground,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const FittedBox(
            child: Text(
              r'$345',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 57,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8, bottom: 16),
            padding: const EdgeInsets.fromLTRB(16, 8, 12, 8),
            decoration: const ShapeDecoration(
              shape: StadiumBorder(),
              color: CpColors.darkBackground,
            ),
            child: const Center(
              widthFactor: 1,
              child: Text.rich(
                TextSpan(
                  text: 'USDC Balance',
                  children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Icon(
                        Icons.expand_more,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: CpButton(
                    text: 'Add Cash',
                    size: CpButtonSize.small,
                    minWidth: MediaQuery.of(context).size.width,
                  ),
                ),
                const SizedBox.square(dimension: 16),
                Expanded(
                  child: CpButton(
                    text: 'Cash Out',
                    size: CpButtonSize.small,
                    minWidth: MediaQuery.of(context).size.width,
                  ),
                ),
              ],
            ),
          )
        ],
      );
}
