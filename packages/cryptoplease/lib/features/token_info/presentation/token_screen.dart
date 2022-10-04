import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/components/token_icon.dart';
import 'package:cryptoplease/app/routes.gr.dart';
import 'package:cryptoplease/app/screens/authenticated/components/navigation_bar/navigation_bar.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/balances/presentation/watch_balance.dart';
import 'package:cryptoplease/core/conversion_rates/presentation/conversion_rates.dart';
import 'package:cryptoplease/core/presentation/format_amount.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/core/user_preferences.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/send_flow/send_flow.dart';
import 'package:cryptoplease/features/token_info/bl/repository.dart';
import 'package:cryptoplease/features/token_info/bl/token_chart_bloc.dart';
import 'package:cryptoplease/features/token_info/bl/token_info_bloc.dart';
import 'package:cryptoplease/features/token_info/presentation/components/balance_widget.dart';
import 'package:cryptoplease/features/token_info/presentation/components/chart_widget.dart';
import 'package:cryptoplease/features/token_info/presentation/components/expandable_text.dart';
import 'package:cryptoplease/features/token_info/presentation/components/loading.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TokenScreen extends StatelessWidget {
  const TokenScreen({super.key, required this.token});

  final Token token;

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<Token>.value(value: token),
          BlocProvider(
            create: (context) => TokenInfoBloc(
              token: token,
              repository: context.read<TokenRepository>(),
            )..add(const FetchInfoRequested()),
          ),
          BlocProvider(
            create: (context) => TokenChartBloc(
              token: token,
              repository: context.read<TokenRepository>(),
            )..add(const FetchChartRequested()),
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
                    children: const [
                      _Header(),
                      TokenChart(),
                      _Buttons(),
                      _TokenInfo(),
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
  const _Header();

  @override
  Widget build(BuildContext context) {
    final token = context.read<Token>();
    final locale = DeviceLocale.localeOf(context);

    final Amount? fiatAmount = context.watchUserFiatBalance(token);

    final fiatCurrency = context.read<UserPreferences>().fiatCurrency;

    final conversionRate =
        context.watchConversionRate(from: token, to: fiatCurrency);

    Amount? tokenRate;

    if (conversionRate != null) {
      tokenRate =
          Amount.fromDecimal(value: conversionRate, currency: fiatCurrency);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                TokenIcon(token: token, size: 60),
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

class _Buttons extends StatelessWidget {
  const _Buttons();

  @override
  Widget build(BuildContext context) {
    final token = context.read<Token>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CpButton(
                text: context.l10n.swap,
                onPressed: () => context.router.navigate(
                  SwapTokenFlowRoute(token: token),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CpButton(
                text: context.l10n.send,
                onPressed: () => context.navigateToSendFt(token),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _TokenInfo extends StatelessWidget {
  const _TokenInfo();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<TokenInfoBloc, TokenInfoState>(
        builder: (context, state) {
          final isLoading = state.processingState.isProcessing;

          if (isLoading) {
            return const SizedBox(
              height: 80,
              child: TokenLoadingIndicator(),
            );
          }

          final name = state.name ?? '-';
          final description = state.description ?? '-';
          final marketRank = state.marketCap ?? 0;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.aboutTokenLabel(name),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 12),
                ExpandableText(
                  text: TextSpan(
                    text: description,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  ),
                  maxLines: 8,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    _InfoRowItem(
                      label: context.l10n.marketCapRank,
                      value: Text('#$marketRank'),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      );
}

class _InfoRowItem extends StatelessWidget {
  const _InfoRowItem({required this.label, required this.value});

  final String label;
  final Widget value;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
          const SizedBox(width: 8),
          DefaultTextStyle(
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
            child: value,
          ),
        ],
      );
}
