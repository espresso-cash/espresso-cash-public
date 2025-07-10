// ignore_for_file: avoid-type-casts

import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/amount_keypad/amount_keypad.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/bottom_button.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/loader.dart';
import '../../../ui/number_formatter.dart';
import '../../../ui/scaling_text.dart';
import '../../../ui/snackbar.dart';
import '../../../ui/theme.dart';
import '../../../ui/value_stream_builder.dart';
import '../../../utils/flow.dart';
import '../../conversion_rates/data/repository.dart';
import '../../conversion_rates/services/token_fiat_balance_service.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../tokens/token.dart';
import '../models/quote_exception.dart';
import '../models/swap_seed.dart';
import '../service/quote_service.dart';
import '../widgets/token_picker.dart';
import 'swap_review_screen.dart';

class TokenSwapInputScreen extends StatefulWidget {
  const TokenSwapInputScreen({super.key, this.initialToken});

  static void push(BuildContext context, {Token? initialToken}) => Navigator.of(context).push<void>(
    MaterialPageRoute(builder: (context) => TokenSwapInputScreen(initialToken: initialToken)),
  );

  final Token? initialToken;

  @override
  State<TokenSwapInputScreen> createState() => _TokenSwapInputScreenState();
}

class _TokenSwapInputScreenState extends State<TokenSwapInputScreen> {
  final _inputAmountController = TextEditingController();
  final _outputAmountController = TextEditingController();
  // ignore: dispose-fields, injected singleton
  late final _quoteService = sl<QuoteService>();

  late Token _inputToken;
  late Token _outputToken;

  Decimal _inputTokenRate = Decimal.fromInt(0);
  Decimal _outputTokenRate = Decimal.fromInt(0);

  double _amountInputWidth = 180.w;
  double _symbolInputWidth = 180.w;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _inputToken = widget.initialToken ?? Token.sol;
    _outputToken = Token.usdc;

    _updateRate(_inputToken, _outputToken);

    _quoteService.addListener(_handleQuoteUpdate);

    _inputAmountController.addListener(_handleAmountChanged);
  }

  void _handleQuoteUpdate() {
    if (!mounted) return;

    final quoteState = _quoteService.value;

    switch (quoteState) {
      case FlowSuccess(:final result):
        final output = result.seed.output;

        _outputAmountController.text = output.format(context.locale, skipSymbol: true);

      case FlowFailure(:final error):
        _outputAmountController.text = '';

        showCpErrorSnackbar(
          context,
          message: switch (error) {
            QuoteRouteNotFoundException() => context.l10n.swap_noRouteFound,
            QuoteRateLimitExceededException() => context.l10n.swap_rateLimitExceeded,
            QuoteGenericException() => context.l10n.swap_genericError,
          },
        );

      default:
        break;
    }
  }

  void _updateQuote() {
    final amount = _inputAmountController.text.toDecimalOrZero(DeviceLocale.localeOf(context));

    if (amount == Decimal.zero) return;

    final inputAmount =
        Amount.fromDecimal(value: amount, currency: CryptoCurrency(token: _inputToken))
            as CryptoAmount;

    _quoteService.updateInput(
      inputAmount: inputAmount,
      outputToken: _outputToken,
      slippage: Slippage.zpFive,
    );
  }

  @override
  void dispose() {
    _quoteService
      ..removeListener(_handleQuoteUpdate)
      ..clear();

    _inputAmountController
      ..removeListener(_handleAmountChanged)
      ..dispose();
    _outputAmountController.dispose();

    super.dispose();
  }

  void _handleAmountChanged() {
    if (!mounted) return;

    final currentInputText = _inputAmountController.text;
    if (currentInputText.isEmpty) {
      setState(() {
        _amountInputWidth = 180.w;
        _symbolInputWidth = 180.w;
        _isExpanded = false;
      });
      _outputAmountController.text = '';
      _quoteService.clear();

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
    final tempToken = _inputToken;

    if (!mounted) return;

    setState(() {
      _inputToken = _outputToken;
      _outputToken = tempToken;

      _inputAmountController.clear();
      _outputAmountController.clear();

      _amountInputWidth = 180.w;
      _symbolInputWidth = 180.w;
      _isExpanded = false;
    });

    await _updateRate(_inputToken, _outputToken);

    _quoteService.clear();
  }

  Future<void> _updateRate(Token inputToken, Token outputToken) async {
    if (!mounted) return;
    await sl<ConversionRatesRepository>().refresh(defaultFiatCurrency, [inputToken, outputToken]);
    if (!mounted) return;
    _inputTokenRate =
        sl<ConversionRatesRepository>().readRate(
          CryptoCurrency(token: inputToken),
          to: defaultFiatCurrency,
        ) ??
        Decimal.zero;
    _outputTokenRate =
        sl<ConversionRatesRepository>().readRate(
          CryptoCurrency(token: outputToken),
          to: defaultFiatCurrency,
        ) ??
        Decimal.zero;

    if (mounted) setState(() {});
  }

  void _handleReviewSwap() {
    final quoteState = _quoteService.value;
    final expiresAt = _quoteService.expiresAt;

    if (!quoteState.isSuccess || expiresAt == null || DateTime.now().isAfter(expiresAt)) {
      if (_inputAmountController.text.isNotEmpty) _updateQuote();

      return;
    }

    final route = switch (quoteState) {
      FlowSuccess(:final result) => result,
      _ => null,
    };

    if (route == null) return;

    TokenSwapReviewScreen.push(context, route: route);
  }

  @override
  Widget build(BuildContext context) => ValueStreamBuilder<CryptoFiatAmount>(
    key: ValueKey(_inputToken),
    create:
        () => (
          sl<TokenFiatBalanceService>().readInvestmentBalance(_inputToken),
          (
            Amount.zero(currency: Currency.usdc) as CryptoAmount,
            Amount.zero(currency: Currency.usd) as FiatAmount,
          ),
        ),
    builder: (context, value) {
      final cryptoForMaxButton = value.$1;

      final fiatRateInput = Amount.fromDecimal(value: _inputTokenRate, currency: Currency.usd);
      final fiatRateOutput = Amount.fromDecimal(value: _outputTokenRate, currency: Currency.usd);

      return CpTheme.dark(
        child: Scaffold(
          appBar: CpAppBar(
            title: Text(context.l10n.swap.toUpperCase()),
            nextButton: _LoadingIndicator(quoteService: _quoteService),
          ),
          backgroundColor: CpColors.deepGreyColor,
          body: SafeArea(
            top: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 14.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 23.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 25.w),
                        child: Text(
                          context.l10n.youPay,
                          style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500),
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
                              controller: _inputAmountController,
                              crypto: cryptoForMaxButton,
                              fiatRate: fiatRateInput,
                              locale: context.locale,
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
                              onSubmitted: (newInputToken) async {
                                if (newInputToken == _inputToken) return;

                                final Token newOutputToken;
                                if (newInputToken == _outputToken) {
                                  newOutputToken = _inputToken;
                                } else {
                                  newOutputToken = _outputToken;
                                }

                                setState(() {
                                  _inputToken = newInputToken;
                                  _outputToken = newOutputToken;

                                  _inputAmountController.clear();
                                  _outputAmountController.clear();

                                  _amountInputWidth = 180.w;
                                  _symbolInputWidth = 180.w;
                                  _isExpanded = false;
                                });

                                await _updateRate(_inputToken, _outputToken);

                                _quoteService.clear();
                              },
                              token: _inputToken,
                              isExpanded: !_isExpanded,
                              showOnlyUserTokens: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 28.h),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: const Divider(thickness: 1, color: CpColors.darkDividerColor),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 12.w),
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                      decoration: const BoxDecoration(
                        color: CpColors.deepGreyColor,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: GestureDetector(
                        onTap: _handleSwitchTokens,
                        child: Assets.icons.swap.svg(height: 28.h, width: 18.w),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: const Divider(thickness: 1, color: CpColors.darkDividerColor),
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
                        child: Row(
                          children: [
                            Text(
                              context.l10n.youReceive,
                              style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(width: 8.w),
                            ListenableBuilder(
                              listenable: _quoteService,
                              builder: (context, _) {
                                final state = _quoteService.value;
                                if (state case FlowFailure()) {
                                  return Text(
                                    'Failed to get quote',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: CpColors.alertRedColor,
                                    ),
                                  );
                                }

                                return const SizedBox.shrink();
                              },
                            ),
                          ],
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
                              controller: _outputAmountController,

                              crypto:
                                  Amount.zero(currency: CryptoCurrency(token: _outputToken))
                                      as CryptoAmount,
                              fiatRate: fiatRateOutput,
                              locale: context.locale,
                              showMaxButton: false,
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: _symbolInputWidth,
                            height: _inputHeight,
                            child: TokenPicker(
                              title: context.l10n.youReceive,
                              token: _outputToken,
                              onSubmitted: (newOutputToken) async {
                                if (newOutputToken == _outputToken) return;

                                final Token newInputToken;
                                if (newOutputToken == _inputToken) {
                                  newInputToken = _outputToken;
                                } else {
                                  newInputToken = _inputToken;
                                }
                                setState(() {
                                  _outputToken = newOutputToken;
                                  _inputToken = newInputToken;

                                  _inputAmountController.clear();
                                  _outputAmountController.clear();

                                  _amountInputWidth = 180.w;
                                  _symbolInputWidth = 180.w;
                                  _isExpanded = false;
                                });

                                await _updateRate(_inputToken, _outputToken);

                                _quoteService.clear();
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
                    controller: _inputAmountController,
                    maxDecimals: _inputToken.decimals,
                  ),
                ),
                SizedBox(height: 16.h),
                ListenableBuilder(
                  listenable: _quoteService,
                  builder: (context, _) {
                    final state = _quoteService.value;

                    return CpBottomButton(
                      text: context.l10n.reviewSwap,
                      onPressed: state.isSuccess ? _handleReviewSwap : null,
                    );
                  },
                ),
                SizedBox(height: 14.h),
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
    required this.locale,
    this.showMaxButton = false,
  });

  final TextEditingController controller;
  final CryptoAmount crypto;
  final Amount fiatRate;
  final Locale locale;
  final bool showMaxButton;

  @override
  State<_TokenAmountInput> createState() => _TokenAmountInputState();
}

class _TokenAmountInputState extends State<_TokenAmountInput> {
  bool _showEquivalent = false;
  double _textHeight = 1.2;
  bool _isMax = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_quantityListener);
    _quantityListener();
  }

  @override
  void didUpdateWidget(_TokenAmountInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_quantityListener);
      widget.controller.addListener(_quantityListener);

      _quantityListener();
    } else if (widget.crypto != oldWidget.crypto) {
      _quantityListener();
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_quantityListener);
    super.dispose();
  }

  void _quantityListener() {
    if (!mounted) return;

    final value = widget.controller.text.toDecimalOrZero(widget.locale);
    final isValueValid = widget.controller.text.isNotEmpty;

    scheduleMicrotask(() {
      if (!mounted) return;
      setState(() {
        _isMax =
            isValueValid && widget.crypto.decimal > Decimal.zero && value == widget.crypto.decimal;

        if (isValueValid) {
          _textHeight = 0.9;
          _showEquivalent = true;
        } else {
          _textHeight = 1.2;
          _showEquivalent = false;
          _isMax = false;
        }
      });
    });
  }

  void _handleMaxPress() {
    if (widget.crypto.decimal > Decimal.zero) {
      if (_isMax) {
        widget.controller.clear();
      } else {
        widget.controller.text = widget.crypto.format(widget.locale, skipSymbol: true);
      }
    } else {
      widget.controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      Container(
        height: _inputHeight,
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
        decoration: const ShapeDecoration(color: CpColors.blackGreyColor, shape: StadiumBorder()),
        child: ValueListenableBuilder<TextEditingValue>(
          valueListenable: widget.controller,
          builder:
              (context, controllerValue, child) => Row(
                children: [
                  Expanded(
                    child: ScalingText(
                      text: controllerValue.text.isEmpty ? '0' : controllerValue.text,
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
                      onPressed: _handleMaxPress,
                      text: _isMax ? context.l10n.clear : context.l10n.max,
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
            r'≈ $' +
                Amount.fromDecimal(
                      value: widget.controller.text.toDecimalOrZero(widget.locale),
                      currency: widget.crypto.currency,
                    )
                    .convert(rate: widget.fiatRate.decimal, to: Currency.usd)
                    .decimal
                    .toStringAsFixed(2),
            style: TextStyle(fontSize: 12.sp, color: Colors.grey),
          ),
        ),
      ),
    ],
  );
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator({required this.quoteService});

  final QuoteService quoteService;

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: quoteService,
    builder:
        (context, _) =>
            quoteService.value.isProcessing ? const LoadingIndicator() : const SizedBox.shrink(),
  );
}

const _inputHeight = 72.0;
