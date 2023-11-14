import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../ui/button.dart';
import '../../../core/blockchain.dart';

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
        size: CpButtonSize.big,
        variant: CpButtonVariant.black,
        width: 250,
        leading: _CircularLogoWidget(chain),
        text: 'USDC on ${chain.name}',
        trailing: const SizedBox.shrink(),
        onPressed: onTap,
      );
}

class _CircularLogoWidget extends StatelessWidget {
  const _CircularLogoWidget(this.chain);

  final Blockchain chain;

  static const size = 40.0;

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
