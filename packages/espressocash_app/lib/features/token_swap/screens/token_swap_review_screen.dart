import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/bottom_button.dart';
import '../../../ui/colors.dart';
import '../../tokens/token.dart';
import '../../tokens/widgets/token_icon.dart';

class TokenSwapReviewScreen extends StatelessWidget {
  const TokenSwapReviewScreen({
    super.key,
    required this.payAmount,
    required this.payToken,
    required this.receiveAmount,
    required this.receiveToken,
  });

  static Future<Decimal?> push(
    BuildContext context, {
    required Token payToken,
    required String payAmount,
    required Token receiveToken,
    required String receiveAmount,
  }) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => TokenSwapReviewScreen(
            payAmount: payAmount,
            payToken: payToken,
            receiveAmount: receiveAmount,
            receiveToken: receiveToken,
          ),
        ),
      );

  final String payAmount;
  final Token payToken;
  final String receiveAmount;
  final Token receiveToken;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: CpColors.deepGreyColor,
        appBar: CpAppBar(
          title: Text(context.l10n.reviewSwap.toUpperCase()),
        ),
        body: Stack(
          children: [
            SafeArea(
              minimum: EdgeInsets.only(bottom: 40.h),
              child: LayoutBuilder(
                builder: (
                  BuildContext context,
                  BoxConstraints viewportConstraints,
                ) =>
                    Column(
                  children: [
                    _TokensInfo(
                      payToken: payToken,
                      payAmount: payAmount,
                      payUsdAmount: '',
                      receiveToken: receiveToken,
                      receiveAmount: receiveAmount,
                      receiveUsdAmount: '',
                    ),
                    SizedBox(height: 36.h),
                    const _SwapInfo(
                      provider: '',
                      bestPrice: '',
                      fees: '',
                      slippage: '',
                      priceImpact: '',
                    ),
                    const Spacer(),
                    CpBottomButton(
                      text: context.l10n.swap,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}

class _TokensInfo extends StatelessWidget {
  const _TokensInfo({
    required this.payToken,
    required this.payAmount,
    required this.payUsdAmount,
    required this.receiveToken,
    required this.receiveAmount,
    required this.receiveUsdAmount,
  });

  final Token payToken;
  final String payAmount;
  final String payUsdAmount;
  final Token receiveToken;
  final String receiveAmount;
  final String receiveUsdAmount;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          _TokenRow(
            label: 'You Pay',
            token: payToken,
            amount: payAmount,
            usdAmount: payUsdAmount,
          ),
          const Divider(color: CpColors.darkDividerColor, thickness: 1),
          _TokenRow(
            label: 'You Receive',
            token: receiveToken,
            amount: receiveAmount,
            usdAmount: receiveUsdAmount,
          ),
        ],
      );
}

class _TokenRow extends StatelessWidget {
  const _TokenRow({
    required this.label,
    required this.token,
    required this.amount,
    required this.usdAmount,
  });

  final String label;
  final Token token;
  final String amount;
  final String usdAmount;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(left: 56.w, right: 20.w, top: 16.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width / 3,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  TokenIcon(token: token, size: 42.w),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                amount,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Text(
                              ' ${token.symbol}',
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          usdAmount,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                          ),
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(28.w)),
          ),
        ),
        child: Column(
          children: [
            _InfoItem(
              label: 'Provider',
              value: provider,
            ),
            SizedBox(height: 6.h),
            _InfoItem(
              label: 'Best Price',
              value: bestPrice,
            ),
            SizedBox(height: 6.h),
            _InfoItem(
              label: context.l10n.fees,
              value: fees,
            ),
            SizedBox(height: 6.h),
            _InfoItem(
              label: 'Slippage',
              value: slippage,
            ),
            SizedBox(height: 6.h),
            _InfoItem(
              label: 'Price Impact',
              value: priceImpact,
            ),
          ],
        ),
      );
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({
    required this.label,
    required this.value,
  });
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.all(8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: CpColors.deepGreyColor,
              ),
            ),
          ],
        ),
      );
}
