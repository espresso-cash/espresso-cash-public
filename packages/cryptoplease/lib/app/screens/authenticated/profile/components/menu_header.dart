import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/accounts/bl/account.dart';
import '../../../../../core/amount.dart';
import '../../../../../core/balances/presentation/watch_balance.dart';
import '../../../../../core/currency.dart';
import '../../../../../core/presentation/format_amount.dart';
import '../../../../../core/tokens/token.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../l10n/device_locale.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../ui/app_bar.dart';
import '../../../../../ui/button.dart';
import '../../../../../ui/colors.dart';
import '../../../../../ui/icon_button.dart';
import '../../../../routes.gr.dart';

class MenuHeader extends StatelessWidget {
  const MenuHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const token = Token.usdc;

    final locale = DeviceLocale.localeOf(context);
    final converted = context.watchUserFiatBalance(token);
    final amount = converted ?? Amount.zero(currency: Currency.usd);
    final formattedAmount = amount.format(locale);

    return Material(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CpAppBar(
            automaticallyImplyLeading: false,
            title: const _AppBarContent(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: FittedBox(
              child: Text(
                formattedAmount,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 57,
                ),
              ),
            ),
          ),
          const _TokenDisplay(token: token),
          _Buttons(
            onAddCash: () => context.router.navigate(
              OnRampRoute(
                wallet: context.read<MyAccount>().wallet,
                token: Token.usdc,
              ),
            ),
            onCashOut: () => context.router.navigate(const OffRampRoute()),
          ),
        ],
      ),
    );
  }
}

class _TokenDisplay extends StatelessWidget {
  const _TokenDisplay({
    Key? key,
    required this.token,
  }) : super(key: key);

  final Token token;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(top: 8, bottom: 16),
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 24,
        ),
        decoration: const ShapeDecoration(
          shape: StadiumBorder(),
          color: CpColors.darkBackground,
        ),
        child: Center(
          widthFactor: 1,
          child: Text(
            context.l10n.tokenBalance(token.symbol),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
}

class _Buttons extends StatelessWidget {
  const _Buttons({
    Key? key,
    required this.onAddCash,
    required this.onCashOut,
  }) : super(key: key);

  final VoidCallback onAddCash;
  final VoidCallback onCashOut;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: CpButton(
                text: context.l10n.addCash,
                size: CpButtonSize.normal,
                minWidth: MediaQuery.of(context).size.width,
                onPressed: onAddCash,
              ),
            ),
            const SizedBox.square(dimension: 24),
            Expanded(
              child: CpButton(
                text: context.l10n.cashOut,
                size: CpButtonSize.normal,
                minWidth: MediaQuery.of(context).size.width,
                onPressed: onCashOut,
              ),
            ),
          ],
        ),
      );
}

class _AppBarContent extends StatelessWidget {
  const _AppBarContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
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
              child: CpIconButton(
                icon: Assets.icons.settingsButtonIcon.svg(),
                onPressed: () => context.router.push(const ProfileRoute()),
              ),
            ),
          ],
        ),
      );
}
