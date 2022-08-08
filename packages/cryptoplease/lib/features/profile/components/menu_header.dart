import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/routes.gr.dart';
import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/balances/bl/balances_bloc.dart';
import 'package:cryptoplease/core/balances/presentation/watch_balance.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/presentation/dialogs.dart';
import 'package:cryptoplease/core/presentation/format_amount.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuHeader extends StatefulWidget {
  const MenuHeader({
    Key? key,
  }) : super(key: key);

  @override
  State<MenuHeader> createState() => _MenuHeaderState();
}

class _MenuHeaderState extends State<MenuHeader> {
  late Token currentToken;

  @override
  void initState() {
    super.initState();
    currentToken = Token.sol;
  }

  Future<void> _onSelectToken() async {
    final route = TokenSelectorRoute(
      availableTokens: context.read<BalancesBloc>().state.userTokens,
      shouldShowBalance: false,
    );
    final newToken = await context.router.push<Token>(route);

    if (newToken != null) {
      setState(() => currentToken = newToken);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasMultipleTokens =
        context.watch<BalancesBloc>().state.userTokens.length > 1;

    final locale = DeviceLocale.localeOf(context);
    final converted = context.watchUserFiatBalance(currentToken);
    final amount = converted ?? Amount.zero(currency: Currency.usd);
    const prefix = r'$';
    final formattedAmount = amount.format(locale, skipSymbol: true);

    return Material(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CpAppBar(
            hasBorder: false,
            automaticallyImplyLeading: false,
            title: const _AppBarContent(),
          ),
          FittedBox(
            child: Text(
              '$prefix $formattedAmount',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 57,
              ),
            ),
          ),
          _BalanceDropdown(
            selectedToken: currentToken,
            onTap: hasMultipleTokens ? _onSelectToken : null,
          ),
          _Buttons(
            onAddCash: () => context.router.navigate(
              AddFundsRoute(wallet: context.read<MyAccount>().wallet),
            ),
            onCashOut: () => showWarningDialog(
              context,
              title: context.l10n.cashOut,
              message: context.l10n.comingSoon,
            ),
          ),
        ],
      ),
    );
  }
}

class _BalanceDropdown extends StatelessWidget {
  const _BalanceDropdown({
    Key? key,
    required this.selectedToken,
    required this.onTap,
  }) : super(key: key);

  final Token selectedToken;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(top: 8, bottom: 16),
        padding: const EdgeInsets.fromLTRB(16, 8, 12, 8),
        decoration: const ShapeDecoration(
          shape: StadiumBorder(),
          color: CpColors.darkBackground,
        ),
        child: InkWell(
          onTap: onTap,
          child: Center(
            widthFactor: 1,
            child: Text.rich(
              TextSpan(
                text: context.l10n.tokenBalance(selectedToken.symbol),
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: onTap != null
                        ? const Icon(Icons.expand_more, color: Colors.white)
                        : const SizedBox(height: 24, width: 4),
                  ),
                ],
              ),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
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
            const SizedBox.square(dimension: 16),
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
                icon: Icons.settings,
                onPressed: () => context.router.push(const ProfileRoute()),
              ),
            ),
          ],
        ),
      );
}
