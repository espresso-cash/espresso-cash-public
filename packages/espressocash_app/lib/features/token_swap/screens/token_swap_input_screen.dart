import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/amount_keypad/amount_keypad.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/bottom_button.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/scaling_text.dart';
import '../../../ui/theme.dart';
import '../../../ui/value_stream_builder.dart';
import '../../conversion_rates/data/repository.dart';
import '../../conversion_rates/services/token_fiat_balance_service.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../tokens/token.dart';
import '../models/swap_seed.dart';
import '../services/quote_service.dart';
import '../widgets/token_picker.dart';
import 'token_swap_review_screen.dart';

class TokenSwapInputScreen extends StatefulWidget {
  const TokenSwapInputScreen({super.key, required this.initialToken});

  static void push(BuildContext context, {required Token initialToken}) =>
      Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) =>
              TokenSwapInputScreen(initialToken: initialToken),
        ),
      );

  final Token initialToken;

  @override
  State<TokenSwapInputScreen> createState() => _TokenSwapInputScreenState();
}

class _TokenSwapInputScreenState extends State<TokenSwapInputScreen> {
  final _payAmountController = TextEditingController();
  final _receiveAmountController = TextEditingController();

  late Token _payToken;
  late Token _receiveToken;

  Decimal _payTokenRate = Decimal.fromInt(0);
  Decimal _receiveTokenRate = Decimal.fromInt(0);

  double _amountInputWidth = 180.w;
  double _symbolInputWidth = 180.w;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _payToken = widget.initialToken;
    _receiveToken = Token.usdc;

    _updateRate(_payToken, _receiveToken);

    sl<QuoteService>().addListener(_handleQuoteUpdate);

    _payAmountController.addListener(_handleAmountChanged);
  }

  void _handleQuoteUpdate() {
    final quote = sl<QuoteService>().value;
    if (quote == null) {
      // Handle null quote (error or invalid input)
      _receiveAmountController.text = '';

      return;
    }

    // Update UI with quote information
    setState(() {
      // Update relevant state variables
      _receiveAmountController.text = quote.output.value.toString();
    });
  }

  void _updateQuote() {
    final amount = Decimal.tryParse(_payAmountController.text);

    if (amount == null) return;

    final inputAmount = Amount.fromDecimal(
      value: amount,
      currency: CryptoCurrency(token: _payToken),
    ) as CryptoAmount;

    sl<QuoteService>().updateInput(
      inputAmount: inputAmount,
      outputToken: _receiveToken,
      slippage: Slippage.zpFive, // TODO
    );
  }

  @override
  void dispose() {
    sl<QuoteService>().clear();
    _payAmountController.dispose();
    _receiveAmountController.dispose();
    super.dispose();
  }

  void _handleAmountChanged() {
    if (_payAmountController.text.isEmpty) {
      setState(() {
        _amountInputWidth = 180.w;
        _symbolInputWidth = 180.w;
        _isExpanded = false;
      });
      _receiveAmountController.text = '';

      return;
    }

    setState(() {
      _amountInputWidth = 260.w;
      _symbolInputWidth = 100.w;
      _isExpanded = true;
    });

    _updateQuote();
  }

  Future<void> _handleSwitchTokens() async {
    final tempToken = _payToken;
    final tempAmount = _payAmountController.text;
    if (!mounted) return;

    setState(() {
      _payToken = _receiveToken;
      _receiveToken = tempToken;
      _payAmountController.text = _receiveAmountController.text;
      _receiveAmountController.text = tempAmount;
    });

    await _updateRate(_payToken, _receiveToken);
  }

  Future<void> _updateRate(Token payToken, Token receiveToken) async {
    await sl<ConversionRatesRepository>()
        .refresh(defaultFiatCurrency, [_payToken, _receiveToken]);
    _payTokenRate = sl<ConversionRatesRepository>().readRate(
          CryptoCurrency(token: payToken),
          to: defaultFiatCurrency,
        ) ??
        Decimal.zero;
    _receiveTokenRate = sl<ConversionRatesRepository>().readRate(
          CryptoCurrency(token: receiveToken),
          to: defaultFiatCurrency,
        ) ??
        Decimal.zero;
  }

  @override
  Widget build(BuildContext context) => ValueStreamBuilder<CryptoFiatAmount>(
        create: () => (
          sl<TokenFiatBalanceService>()
              .readInvestmentBalance(widget.initialToken),
          (
            Amount.zero(currency: Currency.usdc) as CryptoAmount,
            Amount.zero(currency: Currency.usd) as FiatAmount
          )
        ),
        builder: (context, value) {
          final crypto = value.$1;

          final fiatRatePay = Amount.fromDecimal(
            value: _payTokenRate,
            currency: Currency.usd,
          );

          final fiatRateReceive = Amount.fromDecimal(
            value: _receiveTokenRate,
            currency: Currency.usd,
          );

          return CpTheme.dark(
            child: Scaffold(
              appBar: CpAppBar(
                title: Text(context.l10n.swap),
              ),
              backgroundColor: CpColors.deepGreyColor,
              body: SafeArea(
                top: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 23.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 25.w),
                            child: Text(
                              context.l10n.youPay,
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AnimatedContainer(
                                curve: Curves.easeInOut,
                                duration: const Duration(milliseconds: 300),
                                width: _amountInputWidth,
                                child: _TokenAmountInput(
                                  controller: _payAmountController,
                                  crypto: crypto,
                                  fiatRate: fiatRatePay,
                                  showMaxButton: true,
                                ),
                              ),
                              AnimatedContainer(
                                curve: Curves.easeInOut,
                                duration: const Duration(milliseconds: 300),
                                width: _symbolInputWidth,
                                height: _inputHeight,
                                child: TokenPicker(
                                  title: context.l10n.youPay,
                                  onSubmitted: (value) async {
                                    await _updateRate(value, _receiveToken);
                                    if (!mounted) return;
                                    setState(() {
                                      _payToken = value;
                                    });
                                  },
                                  token: _payToken,
                                  isExpanded: !_isExpanded,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32.h),
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 5.h),
                          child: const Divider(
                            thickness: 1,
                            color: CpColors.darkDividerColor,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: ColoredBox(
                            color: CpColors.deepGreyColor,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: GestureDetector(
                                onTap: _handleSwitchTokens,
                                child: Assets.icons.swap
                                    .svg(height: 26.h, width: 18.w),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 23.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 25.w),
                            child: Text(
                              context.l10n.youReceive,
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AnimatedContainer(
                                curve: Curves.easeInOut,
                                duration: const Duration(milliseconds: 300),
                                width: _amountInputWidth,
                                child: _TokenAmountInput(
                                  controller: _receiveAmountController,
                                  crypto: crypto,
                                  fiatRate: fiatRateReceive,
                                  showMaxButton: false,
                                ),
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: _symbolInputWidth,
                                height: _inputHeight,
                                child: TokenPicker(
                                  title: context.l10n.youReceive,
                                  token: _receiveToken,
                                  onSubmitted: (value) async {
                                    await _updateRate(_payToken, value);
                                    if (!mounted) return;
                                    setState(() {
                                      _receiveToken = value;
                                    });
                                  },
                                  isExpanded: !_isExpanded,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: AmountKeypad(
                        controller: _payAmountController,
                        maxDecimals: _payToken.decimals,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    CpBottomButton(
                      text: context.l10n.reviewSwap,
                      onPressed: () {
                        //TODO get route from service

                        // TokenSwapReviewScreen.push(
                        // context,
                        // route: );
                      },
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          );
        },
      );
}

class _TokenAmountInput extends StatefulWidget {
  const _TokenAmountInput({
    required this.controller,
    required this.crypto,
    required this.fiatRate,
    this.showMaxButton = false,
  });

  final TextEditingController controller;
  final CryptoAmount crypto;
  final Amount fiatRate;
  final bool showMaxButton;

  @override
  State<_TokenAmountInput> createState() => _TokenAmountInputState();
}

class _TokenAmountInputState extends State<_TokenAmountInput> {
  bool _showEquivalent = false;
  double _textHeight = 1.2;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_quantityListener);
  }

  void _quantityListener() {
    final isValueValid = widget.controller.text.isNotEmpty;

    setState(() {
      if (isValueValid) {
        _textHeight = 0.9;
        _showEquivalent = true;
      } else {
        _textHeight = 1.2;
        _showEquivalent = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Container(
            height: _inputHeight,
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
            decoration: const ShapeDecoration(
              color: CpColors.blackGreyColor,
              shape: StadiumBorder(),
            ),
            child: ValueListenableBuilder<TextEditingValue>(
              valueListenable: widget.controller,
              builder: (context, value, child) => Row(
                children: [
                  Expanded(
                    child: ScalingText(
                      text: value.text.isEmpty ? '0' : value.text,
                      style: TextStyle(
                        fontSize: 34.sp,
                        fontWeight: FontWeight.w700,
                        height: _textHeight,
                      ),
                    ),
                  ),
                  if (widget.showMaxButton) ...[
                    SizedBox(width: 12.w),
                    CpButton(
                      onPressed: _isMax()
                          ? () => widget.controller.clear()
                          : () => widget.controller.text =
                              '${widget.crypto.decimal}',
                      text: _isMax() ? 'Clear' : 'Max',
                      minWidth: 54,
                      size: CpButtonSize.small,
                      variant: CpButtonVariant.inverted,
                    ),
                  ],
                ],
              ),
            ),
          ),
          Visibility(
            visible: _showEquivalent,
            child: Positioned(
              left: 26,
              bottom: 9,
              child: Text(
                r'≈ $' + _buildUsdcAmountText,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      );

  String get _buildUsdcAmountText {
    final amount = num.tryParse(widget.controller.text);
    if (amount == null) return '0.00';

    return (amount * widget.fiatRate.decimal.toDouble()).toStringAsFixed(2);
  }

  bool _isMax() =>
      (num.tryParse(
            widget.controller.text,
          ) ??
          -1) ==
      widget.crypto.decimal.toDouble();
}

const _inputHeight = 72.0;
