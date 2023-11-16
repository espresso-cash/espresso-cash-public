import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../ui/button.dart';
import '../../../core/blockchain.dart';
import '../../../core/extensions.dart';
import 'arrow.dart';

class OtherWalletButton extends StatelessWidget {
  const OtherWalletButton({
    super.key,
    required this.chain,
    required this.onTap,
  });

  final Blockchain chain;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => CpButton(
        variant: CpButtonVariant.black,
        size: isMobile ? CpButtonSize.big : CpButtonSize.normal,
        width: isMobile ? 350 : 250,
        leading: UsdcLogoWidget(chain),
        text: 'USDC on ${chain.name}',
        trailing: isMobile
            ? const Arrow(color: Colors.white)
            : const SizedBox.shrink(),
        onPressed: onTap,
      );
}

class UsdcLogoWidget extends StatelessWidget {
  const UsdcLogoWidget(this.chain, {super.key, this.size = 40});

  final Blockchain chain;
  final double size;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ClipOval(
              child: SizedBox(
                width: size,
                height: size,
                child: Assets.landing.usdcLogo.image(),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: ClipOval(
                child: SizedBox(
                  width: size * 0.4,
                  height: size * 0.4,
                  child: chain.logo.image(),
                ),
              ),
            ),
          ],
        ),
      );
}
