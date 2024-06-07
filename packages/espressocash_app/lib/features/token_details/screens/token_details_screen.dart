import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../../di.dart';
import '../../../l10n/device_locale.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/theme.dart';
import '../../../ui/value_stream_builder.dart';
import '../../balances/data/token_balance_repository.dart';
import '../../conversion_rates/data/repository.dart';
import '../../conversion_rates/services/token_fiat_balance_service.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../ramp/widgets/ramp_buttons.dart';
import '../../tokens/token.dart';
import '../widgets/token_app_bar.dart';
import '../widgets/token_info.dart';

class TokenDetailsScreen extends StatelessWidget {
  const TokenDetailsScreen({super.key, required this.token});

  static void push(BuildContext context, {required Token token}) =>
      Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => TokenDetailsScreen(token: token),
        ),
      );

  final Token token;

  @override
  Widget build(BuildContext context) => Provider<Token>.value(
        value: token,
        child: CpTheme.dark(
          child: Scaffold(
            backgroundColor: CpColors.darkGoldBackgroundColor,
            body: SafeArea(
              bottom: false,
              child: NestedScrollView(
                headerSliverBuilder: (context, _) => [
                  TokenAppBar(token: token),
                ],
                body: LayoutBuilder(
                  builder: (
                    BuildContext context,
                    BoxConstraints viewportConstraints,
                  ) =>
                      SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: DecoratedBox(
                        decoration: const BoxDecoration(),
                        child: IntrinsicHeight(
                          child: Column(
                            children: [
                              const _TokenHeader(),
                              const SizedBox(height: 24),
                              if (token.isUsdcToken)
                                const _RampButtons()
                              else
                                const _SwapButton(),
                              const SizedBox(height: 24),
                              const Expanded(
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: CpColors.dashboardBackgroundColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(31),
                                      topRight: Radius.circular(31),
                                    ),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 24),
                                      child: Column(
                                        children: [
                                          TokenInfo(),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                'No recent activity',
                                                style: TextStyle(
                                                  color: Color(0xFF484848),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

class _TokenHeader extends StatelessWidget {
  const _TokenHeader();

  @override
  Widget build(BuildContext context) {
    final token = context.watch<Token>();

    final rate = sl<ConversionRatesRepository>().readRate(
          CryptoCurrency(token: token),
          to: defaultFiatCurrency,
        ) ??
        Decimal.zero;

    final fiatRate = Amount.fromDecimal(value: rate, currency: Currency.usd);

    return ValueStreamBuilder<CryptoFiatAmount>(
      create: () => (
        sl<TokenFiatBalanceService>().readInvestmentBalance(token),
        (
          Amount.zero(currency: Currency.usdc) as CryptoAmount,
          Amount.zero(currency: Currency.usd) as FiatAmount
        )
      ),
      builder: (context, value) {
        final crypto = value.$1;
        final fiat = value.$2;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Text.rich(
                TextSpan(
                  text: 'Balance ',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: fiat.format(context.locale),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              FittedBox(
                child: Text(
                  crypto.format(
                    context.locale,
                    maxDecimals: 4,
                  ),
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 59,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text.rich(
                TextSpan(
                  text: 'Price ',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: fiatRate.format(context.locale),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RampButtons extends StatelessWidget {
  const _RampButtons();

  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AddCashButton(),
            SizedBox(width: 16),
            CashOutButton(),
          ],
        ),
      );
}

class _SwapButton extends StatelessWidget {
  const _SwapButton();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CpButton(
              text: 'Swap',
              minWidth: 106,
              size: CpButtonSize.normal,
              onPressed: () {},
            ),
            const SizedBox(width: 8),
            CpButton(
              text: 'Send',
              minWidth: 106,
              size: CpButtonSize.normal,
              onPressed: () {},
            ),
          ],
        ),
      );
}

extension on Token {
  bool get isUsdcToken => address == Token.usdc.address;
}
