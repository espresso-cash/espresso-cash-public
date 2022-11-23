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
import '../../l10n/l10n.dart';
import '../../ui/colors.dart';
import '../../ui/loader.dart';
import '../../ui/navigation_bar/navigation_bar.dart';
import '../../ui/theme.dart';
import '../../ui/token_icon.dart';
import '../favorite_tokens/module.dart';
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
                      const SizedBox(height: 4),
                      Text(
                        token.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 26,
                        ),
                      ),
                      const SizedBox(height: 4),
                      _Chart(token: token),
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

  static const double _tokenSize = 68;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          height: _tokenSize,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: CpTokenIcon(token: token, size: _tokenSize),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: BackButton(onPressed: () => context.router.pop()),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FavoriteWidget(token: token),
              ),
            ],
          ),
        ),
      );
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
                description: context.l10n.failedToLoadDescription,
                marketCapRank: null,
              ),
            ),
            success: (data) => TokenDetailsWidget(data: data),
          );
        },
      );
}

class _Chart extends StatefulWidget {
  const _Chart({required this.token});

  final Token token;

  @override
  State<_Chart> createState() => __ChartState();
}

class __ChartState extends State<_Chart> {
  TokenChartItem? _selected;

  @override
  Widget build(BuildContext context) {
    final Amount? fiatAmount = context.watchUserFiatBalance(widget.token);

    final locale = DeviceLocale.localeOf(context);

    //TODO update to value from coingecko api
    final fiatCurrency = context.read<UserPreferences>().fiatCurrency;
    final Amount? tokenRate = context
        .watchConversionRate(from: widget.token, to: fiatCurrency)
        ?.let((it) => Amount.fromDecimal(value: it, currency: fiatCurrency));

    return Column(
      children: [
        if (_selected == null)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PriceWidget(
                label: context.l10n.price,
                amount: tokenRate?.format(locale) ?? '-',
              ),
              if (fiatAmount != null && fiatAmount.value != 0) ...[
                const SizedBox(width: 24),
                PriceWidget(
                  label: context.l10n.yourBalance,
                  amount: fiatAmount.format(DeviceLocale.localeOf(context)),
                ),
              ]
            ],
          )
        else
          Text(
            '\$${_selected?.price?.toStringAsFixed(2) ?? '-'}',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        const SizedBox(height: 6),
        //TODO
        const Text(
          // r'+$1.15 (2.95%) Past Week',
          '',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
        TokenChart(
          token: widget.token,
          onSelect: (item) {
            setState(() {
              _selected = item;
            });
          },
        ),
      ],
    );
  }
}
