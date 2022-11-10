import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../core/amount.dart';
import '../../core/balances/presentation/watch_balance.dart';
import '../../core/conversion_rates/context_ext.dart';
import '../../core/presentation/format_amount.dart';
import '../../core/tokens/token.dart';
import '../../core/user_preferences.dart';
import '../../di.dart';
import '../../l10n/device_locale.dart';
import '../../ui/colors.dart';
import '../../ui/loader.dart';
import '../../ui/navigation_bar/navigation_bar.dart';
import '../../ui/theme.dart';
import '../../ui/token_icon.dart';
import '../token_chart/token_chart.dart';
import 'src/token_details.dart';
import 'src/token_details_bloc.dart';
import 'src/widgets/balance_widget.dart';
import 'src/widgets/token_details_widget.dart';

class TokenDetailsScreen extends StatelessWidget {
  const TokenDetailsScreen({super.key, required this.token});

  final Token token;

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<TokenDetailsBloc>(param1: token)
              ..add(const FetchDetailsRequested()),
          ),
        ],
        child: CpTheme.dark(
          child: Scaffold(
            backgroundColor: CpColors.darkBackground,
            body: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.only(bottom: cpNavigationBarheight),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _Header(token: token),
                      TokenChart(token: token),
                      _Content(token: token),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

class _Header extends StatelessWidget {
  const _Header({required this.token});

  final Token token;

  @override
  Widget build(BuildContext context) {
    final locale = DeviceLocale.localeOf(context);

    final Amount? fiatAmount = context.watchUserFiatBalance(token);

    final fiatCurrency = context.read<UserPreferences>().fiatCurrency;
    final Amount? tokenRate = context
        .watchConversionRate(from: token, to: fiatCurrency)
        ?.let((it) => Amount.fromDecimal(value: it, currency: fiatCurrency));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                CpTokenIcon(token: token, size: 60),
                const SizedBox(height: 4),
                Text(
                  token.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 26,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  tokenRate?.format(locale) ?? '-',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: BackButton(onPressed: () => context.router.pop()),
          ),
          if (fiatAmount != null && fiatAmount.value != 0)
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BalancePillWidget(fiatAmount.format(locale)),
              ),
            )
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.token});

  final Token token;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<TokenDetailsBloc, TokenDetailsState>(
        builder: (context, state) {
          const loader = SizedBox(
            height: 80,
            child: LoadingIndicator(),
          );

          return state.when(
            initial: () => loader,
            processing: () => loader,
            failure: (_) => TokenDetailsWidget(
              data: TokenDetails(
                name: token.name,
                description: 'Failed to load description',
                marketCapRank: null,
              ),
            ),
            success: (data) => TokenDetailsWidget(data: data),
          );
        },
      );
}
