import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/amount.dart';
import '../../../../core/balances/presentation/refresh_balance_wrapper.dart';
import '../../../../core/conversion_rates/amount_ext.dart';
import '../../../../core/conversion_rates/bl/repository.dart';
import '../../../../core/currency.dart';
import '../../../../core/presentation/format_amount.dart';
import '../../../../core/presentation/page_fade_wrapper.dart';
import '../../../../core/tokens/token_list.dart';
import '../../../../di.dart';
import '../../../../features/favorite_tokens/widgets/extensions.dart';
import '../../../../features/favorite_tokens/widgets/favorite_tokens_list.dart';
import '../../../../features/incoming_single_link_payments/widgets/extensions.dart';
import '../../../../features/investments/widgets/crypto_investments.dart';
import '../../../../features/onboarding/widgets/onboarding_notice.dart';
import '../../../../features/outgoing_direct_payments/widgets/extensions.dart';
import '../../../../features/payment_request/models/payment_request.dart';
import '../../../../features/popular_tokens/widgets/extensions.dart';
import '../../../../features/popular_tokens/widgets/popular_token_list.dart';
import '../../../../features/qr_scanner/models/qr_scanner_request.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/colors.dart';
import '../../../../ui/icon_button.dart';
import '../../../../ui/navigation_bar/navigation_bar.dart';
import 'components/investment_header.dart';
import 'components/popular_crypto_header.dart';
import 'components/start_investing_header.dart';

class InvestmentsScreen extends StatefulWidget {
  const InvestmentsScreen({Key? key}) : super(key: key);

  @override
  State<InvestmentsScreen> createState() => _InvestmentsScreenState();
}

class _InvestmentsScreenState extends State<InvestmentsScreen> {
  Future<void> _onQrScanner() async {
    final request =
        await context.router.push<QrScannerRequest>(const QrScannerRoute());

    if (request == null) return;
    if (!mounted) return;

    if (request is QrScannerTipRequest) {
      final id = await context.createISLP(request.paymentData);

      if (!mounted) return;
      await context.router.push(IncomingSingleLinkRoute(id: id));

      return;
    }

    final recipient = request.recipient;
    if (recipient == null) return;

    final name = request.mapOrNull(
      solanaPay: (r) => r.request.label,
      address: (r) => r.addressData.name,
    );
    final requestAmount = request.whenOrNull(
      solanaPay: (r) => r.cryptoAmount(sl<TokenList>()),
    );

    const cryptoCurrency = Currency.usdc;

    const fiatAmount = FiatAmount(
      value: 0,
      fiatCurrency: Currency.usd,
    );

    final cryptoAmount = fiatAmount.toTokenAmount(
          cryptoCurrency.token,
          ratesRepository: context.read<ConversionRatesRepository>(),
        ) ??
        const CryptoAmount(value: 0, cryptoCurrency: cryptoCurrency);

    final isEnabled = requestAmount == null || requestAmount.value == 0;
    final initialAmount = requestAmount ?? fiatAmount;
    final formatted = initialAmount.value == 0
        ? ''
        : initialAmount.format(
            DeviceLocale.localeOf(context),
            skipSymbol: true,
          );

    final fiatDecimal = await context.router.push<Decimal>(
      ODPConfirmationRoute(
        initialAmount: formatted,
        recipient: recipient,
        label: name,
        token: cryptoCurrency.token,
        isEnabled: isEnabled,
      ),
    );
    if (!mounted) return;

    if (fiatDecimal != null) {
      final id = await context.createODP(
        amountInUsdc: cryptoAmount.decimal,
        receiver: recipient,
        reference: request.reference,
      );

      if (!mounted) return;
      await context.router.push(ODPDetailsRoute(id: id));
    }
  }

  @override
  Widget build(BuildContext context) => PageFadeWrapper(
        child: Container(
          padding: const EdgeInsets.only(bottom: cpNavigationBarheight),
          child: RefreshBalancesWrapper(
            builder: (context, onRefresh) => RefreshIndicator(
              displacement: 80,
              onRefresh: () => Future.wait([
                onRefresh(),
                context.refreshPopularTokens(),
                context.refreshFavorites(),
              ]),
              color: CpColors.primaryColor,
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    shape: const Border(),
                    title: _AppBarContent(onQrScanner: _onQrScanner),
                    pinned: true,
                    snap: false,
                    floating: false,
                    elevation: 0,
                    backgroundColor: Colors.white,
                  ),
                  const SliverToBoxAdapter(child: InvestmentHeader()),
                  const SliverToBoxAdapter(child: OnboardingNotice()),
                  const SliverToBoxAdapter(child: SizedBox(height: 45)),
                  const SliverToBoxAdapter(child: StartInvestingHeader()),
                  const SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    sliver: CryptoInvestments(),
                  ),
                  const FavoriteTokenList(),
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                  const SliverToBoxAdapter(child: PopularCryptoHeader()),
                  const PopularTokenList(),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: max(
                        0,
                        MediaQuery.of(context).padding.bottom -
                            cpNavigationBarheight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class _AppBarContent extends StatelessWidget {
  const _AppBarContent({Key? key, required this.onQrScanner}) : super(key: key);
  final VoidCallback onQrScanner;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: kToolbarHeight,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              left: 0,
              child: Row(
                children: [
                  CpIconButton(
                    icon: Assets.icons.qrScannerBlack.svg(height: 26),
                    onPressed: onQrScanner,
                  ),
                ],
              ),
            ),
            Center(
              child: Assets.images.logoDark.image(height: 32),
            ),
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              child: Row(
                children: [
                  CpIconButton(
                    icon: Assets.icons.searchButtonIcon.svg(),
                    onPressed: () => context.router.push(TokenSearchRoute()),
                  ),
                  const SizedBox(width: 12),
                  CpIconButton(
                    icon: Assets.icons.settingsButtonIcon.svg(),
                    onPressed: () => context.router.push(const ProfileRoute()),
                  )
                ],
              ),
            ),
          ],
        ),
      );
}
