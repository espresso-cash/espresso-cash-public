import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/presentation/format_amount.dart';
import 'package:cryptoplease/presentation/screens/authenticated/profile/component/address_view.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class SolanaPayScreen extends StatelessWidget {
  const SolanaPayScreen({
    Key? key,
    required this.address,
    required this.fiatAmount,
    required this.cryptoAmount,
  }) : super(key: key);

  final String address;
  final FiatAmount fiatAmount;
  final CryptoAmount cryptoAmount;

  @override
  Widget build(BuildContext context) {
    final locale = DeviceLocale.localeOf(context);

    return Scaffold(
      body: CpTheme.light(
        child: _SolanaPayBackground(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Spacer(),
                    Assets.icons.solanaPay.svg(width: 86),
                    const Spacer(),
                    const Text('You are making an instant payment of'),
                    Text(
                      '${cryptoAmount.format(locale)} (≈${fiatAmount.format(locale)}) to',
                    ),
                    AddressView(address: address),
                  ],
                ),
              ),
              Flexible(
                child: Container(),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SolanaPayBackground extends StatelessWidget {
  const _SolanaPayBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
        color: CpColors.primaryColor,
        child: Stack(
          children: [
            Positioned(
              child: Assets.images.solanaPayBkg.image(),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    stops: const [0.6, 0.7, 1],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      CpColors.primaryColor,
                      CpColors.primaryColor.withOpacity(0.5),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            child,
          ],
        ),
      );
}
