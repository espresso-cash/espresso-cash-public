import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/balances/bl/balances_bloc.dart';
import 'package:cryptoplease/core/conversion_rates/bl/repository.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/presentation/format_amount.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuHeader extends StatefulWidget {
  const MenuHeader({
    Key? key,
    required this.selectedToken,
    required this.onDropdownTap,
  }) : super(key: key);

  final Token selectedToken;
  final VoidCallback onDropdownTap;

  @override
  State<MenuHeader> createState() => _MenuHeaderState();
}

class _MenuHeaderState extends State<MenuHeader> {
  late final BalancesBloc balancesBloc;
  late final ConversionRatesRepository conversionRatesRepository;

  @override
  void initState() {
    conversionRatesRepository = context.read<ConversionRatesRepository>();
    balancesBloc = context.read<BalancesBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<BalancesBloc, BalancesState>(
        bloc: balancesBloc,
        builder: (context, state) {
          final locale = DeviceLocale.localeOf(context);
          final balance = state.balances[widget.selectedToken];
          final converted = balance?.map(
            fiat: identity,
            crypto: (c) => c.toFiatAmount(
              Currency.usd,
              ratesRepository: conversionRatesRepository,
            ),
          );
          final amount = converted ?? Amount.zero(currency: Currency.usd);
          final formatted = amount.format(locale);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CpAppBar(
                hasBorder: false,
                automaticallyImplyLeading: false,
                title: const _AppBarContent(),
              ),
              FittedBox(
                child: Text(
                  formatted,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 57,
                  ),
                ),
              ),
              _BalanceDropdown(
                selectedToken: widget.selectedToken,
                onTap: widget.onDropdownTap,
              ),
              const _Buttons(),
            ],
          );
        },
      );
}

class _BalanceDropdown extends StatelessWidget {
  const _BalanceDropdown({
    Key? key,
    required this.selectedToken,
    required this.onTap,
  }) : super(key: key);

  final Token selectedToken;
  final VoidCallback onTap;

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
                text: '${selectedToken.symbol} Balance',
                children: const [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Icon(
                      Icons.expand_more,
                      color: Colors.white,
                    ),
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
  const _Buttons({Key? key}) : super(key: key);

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
              child: Container(
                width: 32,
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
      );
}
