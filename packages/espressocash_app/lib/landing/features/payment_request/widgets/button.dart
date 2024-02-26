import 'package:flutter/material.dart';

import '../../../../features/blockchain/models/blockchain.dart';
import '../../../../gen/assets.gen.dart';
import '../../../core/extensions.dart';
import 'arrow.dart';

class OtherWalletButton extends StatelessWidget {
  //TODO remove if not needed
  const OtherWalletButton({
    super.key,
    required this.chain,
    required this.onTap,
  });

  final Blockchain chain;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Container(
        width: isMobile ? 350 : 250,
        height: 63,
        decoration: const ShapeDecoration(
          color: Colors.black,
          shape: StadiumBorder(),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                UsdcLogoWidget(chain),
                Expanded(
                  child: Text(
                    'USDC on ${chain.displayName}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.13,
                    ),
                  ),
                ),
                if (isMobile)
                  const Arrow(color: Colors.white)
                else
                  const SizedBox(width: 12),
              ],
            ),
          ),
        ),
      );
}

class UsdcLogoWidget extends StatelessWidget {
  const UsdcLogoWidget(this.chain, {super.key, this.size = 40});

  final Blockchain chain;
  final double size;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: size + 10,
        height: size + 10,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Center(
              child: Assets.landing.usdcLogo.image(
                height: size,
                width: size,
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: ClipOval(
                child: SizedBox(
                  width: size * 0.58,
                  height: size * 0.58,
                  child: chain.logo.image(),
                ),
              ),
            ),
          ],
        ),
      );
}

class MetamaskButton extends StatelessWidget {
  const MetamaskButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Container(
        width: isMobile ? 350 : 250,
        height: 63,
        decoration: const ShapeDecoration(
          color: Colors.black,
          shape: StadiumBorder(),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: ListTile(
                leading: Assets.landing.metamask.image(
                  height: 40,
                  width: 40,
                ),
                title: const Text(
                  'Metamask',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.13,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
