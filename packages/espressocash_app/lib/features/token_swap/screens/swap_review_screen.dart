import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../di.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/bottom_button.dart';
import '../../../ui/colors.dart';
import '../../../ui/loader.dart';
import '../../../utils/flow.dart';
import '../../conversion_rates/data/repository.dart';
import '../../conversion_rates/services/amount_ext.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../tokens/widgets/token_icon.dart';
import '../models/swap_route.dart';
import '../models/swap_seed.dart';
import '../service/quote_service.dart';
import '../widgets/extensions.dart';
import 'swap_details_screen.dart';

class TokenSwapReviewScreen extends StatefulWidget {
  const TokenSwapReviewScreen({super.key, required this.route});

  static Future<bool?> push(BuildContext context, {required SwapRoute route}) => Navigator.of(
    context,
  ).push(MaterialPageRoute(builder: (context) => TokenSwapReviewScreen(route: route)));

  final SwapRoute route;

  @override
  State<TokenSwapReviewScreen> createState() => _TokenSwapReviewScreenState();
}

class _TokenSwapReviewScreenState extends State<TokenSwapReviewScreen> {
  late SwapRoute _currentRoute;
  // ignore: dispose-fields, injected singleton
  late final _quoteService = sl<QuoteService>();

  @override
  void initState() {
    super.initState();
    _currentRoute = widget.route;
  }

  Future<void> _handleConfirmSwap() async {
    final id = await context.createSwap(_currentRoute);

    if (!mounted) return;

    SwapDetailsScreen.replace(context, id: id);
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: _quoteService,
    builder: (context, _) {
      final locale = DeviceLocale.localeOf(context);
      final quoteState = _quoteService.value;
      final isLoading = quoteState.isProcessing;

      if (quoteState case FlowSuccess(:final result)) {
        _currentRoute = result;
      }

      final input = _currentRoute.seed.input;
      final output = _currentRoute.seed.output;

      final provider = _currentRoute.providerLabel;
      final slippage = _currentRoute.seed.slippage.toPercent();
      final feesInUsdc = _currentRoute.fee.format(locale, roundInteger: true);
      final priceImpact = double.parse(_currentRoute.priceImpact).floor().toString();
      final platformFeePercent = _currentRoute.platformFeePercent;

      final ratio = (output.decimal / input.decimal).toDouble().toStringAsFixed(2);

      final bestPrice =
          '1 ${input.cryptoCurrency.token.symbol} = $ratio ${output.cryptoCurrency.token.symbol}';

      return Scaffold(
        backgroundColor: CpColors.deepGreyColor,
        appBar: CpAppBar(
          title: Text(context.l10n.reviewSwap.toUpperCase()),
          nextButton: isLoading ? const LoadingIndicator() : null,
        ),
        body: Stack(
          children: [
            SafeArea(
              minimum: EdgeInsets.only(bottom: 40.h),
              child: LayoutBuilder(
                builder:
                    (BuildContext context, BoxConstraints viewportConstraints) => Column(
                      children: [
                        SizedBox(height: 24.h),
                        _TokensInfo(payAmount: input, receiveAmount: output),
                        SizedBox(height: 36.h),
                        _SwapInfo(
                          provider: provider,
                          bestPrice: bestPrice,
                          fees: feesInUsdc,
                          slippage: '$slippage%',
                          priceImpact: '$priceImpact%',
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          context.l10n.espressoCashFee(platformFeePercent),
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: CpColors.greyColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Spacer(),
                        CpBottomButton(
                          text: context.l10n.swap,
                          onPressed: isLoading ? null : _handleConfirmSwap,
                        ),
                      ],
                    ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

class _TokensInfo extends StatelessWidget {
  const _TokensInfo({required this.payAmount, required this.receiveAmount});

  final CryptoAmount payAmount;
  final CryptoAmount receiveAmount;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      _TokenRow(label: context.l10n.youPay, amount: payAmount),
      SizedBox(height: 16.h),
      const Divider(color: CpColors.darkDividerColor, thickness: 1),
      _TokenRow(label: context.l10n.youReceive, amount: receiveAmount),
    ],
  );
}

class _TokenRow extends StatelessWidget {
  const _TokenRow({required this.label, required this.amount});

  final String label;
  final CryptoAmount amount;

  @override
  Widget build(BuildContext context) {
    final usdAmount = amount
        .toFiatAmount(defaultFiatCurrency, ratesRepository: sl<ConversionRatesRepository>())
        ?.format(context.locale);

    return Padding(
      padding: EdgeInsets.only(left: 56.w, right: 20.w, top: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width / 3,
            child: Text(label, style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500)),
          ),
          Expanded(
            child: Row(
              children: [
                TokenIcon(token: amount.token, size: 42.w),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        amount.format(context.locale),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        usdAmount ?? '',
                        maxLines: 2,
                        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SwapInfo extends StatelessWidget {
  const _SwapInfo({
    required this.provider,
    required this.bestPrice,
    required this.fees,
    required this.slippage,
    required this.priceImpact,
  });

  final String provider;
  final String bestPrice;
  final String fees;
  final String slippage;
  final String priceImpact;

  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.symmetric(horizontal: 22.w),
    padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 28.w),
    decoration: ShapeDecoration(
      color: CpColors.blackGreyColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(28.w))),
    ),
    child: Column(
      children: [
        _InfoItem(label: context.l10n.provider, value: provider),
        SizedBox(height: 6.h),
        _InfoItem(label: context.l10n.bestPrice, value: bestPrice),
        SizedBox(height: 6.h),
        _InfoItem(label: context.l10n.fees, value: fees),
        SizedBox(height: 6.h),
        _InfoItem(label: context.l10n.slippage, value: slippage),
        SizedBox(height: 6.h),
        _InfoItem(label: context.l10n.priceImpact, value: priceImpact),
      ],
    ),
  );
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.all(8.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
        Text(
          value,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: CpColors.greyColor),
        ),
      ],
    ),
  );
}
