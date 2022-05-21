import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/presentation/format_amount.dart';
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
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
                      const Text(
                        'You are making an\ninstant payment of',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '${cryptoAmount.format(locale)} (≈${fiatAmount.format(locale)}) to',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      const SizedBox(height: 24),
                      _AddressFieldView(address: address),
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Pay with',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _PaymentOptionChip(
                        title: 'Crypto Please',
                        titleColor: CpColors.primaryTextColor,
                        backgroundColor: CpColors.yellowColor,
                        icon: Assets.icons.cryptoPlease.image(),
                        onTap: () => null,
                      ),
                      const SizedBox(height: 8),
                      _PaymentOptionChip(
                        title: 'Phantom',
                        titleColor: Colors.white,
                        backgroundColor: const Color(0xff7a72f1),
                        icon: Assets.icons.phantom.image(),
                        onTap: () => null,
                      ),
                      const SizedBox(height: 8),
                      _PaymentOptionChip(
                        title: 'Solflare',
                        titleColor: Colors.white,
                        backgroundColor: const Color(0xff443d34),
                        icon: Assets.icons.solflare.image(),
                        onTap: () => null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PaymentOptionChip extends StatelessWidget {
  const _PaymentOptionChip({
    Key? key,
    required this.title,
    required this.icon,
    required this.backgroundColor,
    required this.titleColor,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final Widget icon;
  final Color backgroundColor;
  final Color titleColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 45,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: backgroundColor,
          ),
          child: Stack(
            children: [
              Center(
                child: Text(
                  title.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: titleColor,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Roboto',
                    fontSize: 16,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                child: SizedBox.square(dimension: 28, child: icon),
              ),
            ],
          ),
        ),
      );
}

class _AddressFieldView extends StatelessWidget {
  const _AddressFieldView({
    Key? key,
    required this.address,
  }) : super(key: key);

  final String address;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: const BoxDecoration(
          color: CpColors.lightButtonBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            address,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'Roboto',
              color: CpColors.primaryTextColor,
            ),
          ),
        ),
      );
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
            OverflowBox(
              alignment: Alignment.topCenter,
              maxWidth: MediaQuery.of(context).size.width * 1.2,
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
