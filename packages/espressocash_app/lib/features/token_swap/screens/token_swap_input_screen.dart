import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/amount_keypad/amount_keypad.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/bottom_button.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/theme.dart';
import '../../../ui/value_stream_builder.dart';
import '../../conversion_rates/data/repository.dart';
import '../../conversion_rates/services/token_fiat_balance_service.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../tokens/token.dart';
import '../widgets/token_picker.dart';
import 'token_swap_confirmation_screen.dart';

class TokenSwapInputScreen extends StatefulWidget {
  const TokenSwapInputScreen({super.key, required this.token});

  static void push(BuildContext context, {required Token token}) =>
      Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => TokenSwapInputScreen(token: token),
        ),
      );

  final Token token;

  @override
  State<TokenSwapInputScreen> createState() => _TokenSwapInputScreenState();
}

class _TokenSwapInputScreenState extends State<TokenSwapInputScreen> {
  final _payAmountController = TextEditingController();
  final _receiveAmountController = TextEditingController();

  late Token _receiveToken;
  late Token _payToken;

  late Decimal _payTokenRate = Decimal.fromInt(0);
  late Decimal _receiveTokenRate = Decimal.fromInt(0);

  double _amountInputWidth = 180;
  double _symbolInputWidth = 180;

  bool _isPayAmountChanging = false;
  bool _isReceiveAmountChanging = false;
  bool _isExpanded = false;

  bool _isPayFocused = true;

  @override
  void initState() {
    super.initState();
    _payToken = widget.token;
    _receiveToken = Token.usdc;

    _updateRate(widget.token, Token.usdc);

    _payAmountController.addListener(_onPayAmountChanged);
    _receiveAmountController.addListener(_onReceiveAmountChanged);
  }

  @override
  void dispose() {
    _payAmountController.dispose();
    _receiveAmountController.dispose();
    super.dispose();
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

  void _onPayAmountChanged() {
    if (_isReceiveAmountChanging) return;
    if (_payAmountController.text.isEmpty) {
      setState(() {
        _amountInputWidth = 180;
        _symbolInputWidth = 180;
        _isExpanded = false;
      });
      _receiveAmountController.text = '';

      return;
    }

    _isPayAmountChanging = true;

    final payAmount =
        Decimal.tryParse(_payAmountController.text) ?? Decimal.zero;
    final receiveAmount = payAmount * _payTokenRate;
    _receiveAmountController.text = receiveAmount.round(scale: 2).toString();

    setState(() {
      _amountInputWidth = 260;
      _symbolInputWidth = 100;
      _isExpanded = true;
    });

    _isPayAmountChanging = false;
  }

  void _onReceiveAmountChanged() {
    if (_isPayAmountChanging) return;
    if (_receiveAmountController.text.isEmpty) {
      setState(() {
        _amountInputWidth = 180;
        _symbolInputWidth = 180;
        _isExpanded = false;
      });
      _payAmountController.text = '';

      return;
    }

    _isReceiveAmountChanging = true;

    final receiveAmount =
        Decimal.tryParse(_receiveAmountController.text) ?? Decimal.zero;

    final payAmount = receiveAmount / _payTokenRate;
    _payAmountController.text = payAmount.toDouble().toStringAsFixed(2);

    setState(() {
      _amountInputWidth = 260;
      _symbolInputWidth = 100;
      _isExpanded = true;
    });

    _isReceiveAmountChanging = false;
  }

  void _onPayInputTap() {
    if (!_isPayFocused) {
      setState(() => _isPayFocused = true);
    }
  }

  void _onReceiveInputTap() {
    if (_isPayFocused) {
      setState(() => _isPayFocused = false);
    }
  }

  @override
  Widget build(BuildContext context) => ValueStreamBuilder<CryptoFiatAmount>(
        create: () => (
          sl<TokenFiatBalanceService>().readInvestmentBalance(widget.token),
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

          return Provider<Token>.value(
            value: widget.token,
            child: CpTheme.dark(
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
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 23.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 25.0),
                              child: Text(
                                'You Pay',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
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
                                    showMaxButton: false,
                                    isFocused: _isPayFocused,
                                    onTap: _onPayInputTap,
                                  ),
                                ),
                                AnimatedContainer(
                                  curve: Curves.easeInOut,
                                  duration: const Duration(milliseconds: 300),
                                  width: _symbolInputWidth,
                                  child: TokenPicker(
                                    title: 'You Pay',
                                    onSubmitted: (value) async {
                                      await _updateRate(
                                        value,
                                        _receiveToken,
                                      );
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
                      const SizedBox(height: 32),
                      Stack(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Divider(
                              thickness: 1,
                              color: Color.fromRGBO(63, 60, 61, 1),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: ColoredBox(
                              color: CpColors.deepGreyColor,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                ),
                                child: Assets.icons.swap.svg(
                                  height: 26.69,
                                  width: 17.74,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 23.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 25.0),
                              child: Text(
                                'You Receive',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
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
                                    isFocused: !_isPayFocused,
                                    onTap: _onReceiveInputTap,
                                  ),
                                ),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  width: _symbolInputWidth,
                                  child: TokenPicker(
                                    title: 'You Receive',
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
                          controller: _isPayFocused
                              ? _payAmountController
                              : _receiveAmountController,
                          maxDecimals: 4,
                        ),
                      ),
                      const SizedBox(height: 16),
                      CpBottomButton(
                        text: 'Review Swap',
                        onPressed: () => TokenSwapConfirmationScreen.push(
                          context,
                          payToken: _payToken,
                          receiveToken: _receiveToken,
                          payAmount: _payAmountController.text,
                          receiveAmount: _receiveAmountController.text,
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
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
    required this.isFocused,
    required this.onTap,
  });

  final TextEditingController controller;
  final CryptoAmount crypto;
  final Amount fiatRate;
  final bool showMaxButton;
  final bool isFocused;
  final VoidCallback onTap;

  @override
  State<_TokenAmountInput> createState() => _TokenAmountInputState();
}

class _TokenAmountInputState extends State<_TokenAmountInput> {
  bool _visibility = false;
  double _textHeight = 1.2;
  double _fontSize = 34.0;

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
        _visibility = true;
      } else {
        _textHeight = 1.2;
        _visibility = false;
      }

      _fontSize = _calculateFontSize(widget.controller.text);
    });
  }

  double _calculateFontSize(String text) {
    double fontSize = 34;

    final double textWidth = _calculateTextWidth(text, fontSize);

    if (textWidth > 245) {
      fontSize *= 245 / textWidth;
    }

    return fontSize;
  }

  double _calculateTextWidth(String text, double fontSize) {
    final textSpan = TextSpan(
      text: text,
      style: TextStyle(fontSize: fontSize),
    );

    final textPainter = TextPainter(
      text: textSpan,
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    return textPainter.size.width;
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: widget.onTap,
        child: Stack(
          children: [
            Container(
              height: 72,
              padding: const EdgeInsets.only(
                top: 16,
                bottom: 20,
                left: 24,
                right: 24,
              ),
              decoration: BoxDecoration(
                color: CpColors.blackGreyColor,
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                border: Border.all(
                  color: widget.isFocused ? Colors.white : Colors.transparent,
                  width: 1,
                ),
              ),
              child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: widget.controller,
                builder: (context, value, child) => Row(
                  children: [
                    Expanded(
                      child: Text(
                        value.text.isEmpty ? '0' : value.text,
                        style: TextStyle(
                          fontSize: _fontSize,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: _textHeight,
                        ),
                      ),
                    ),
                    if (widget.showMaxButton)
                      CpButton(
                        onPressed: _isMax()
                            ? () => widget.controller.text = ''
                            : () => widget.controller.text =
                                '${widget.crypto.decimal}',
                        text: _isMax() ? 'Clear' : 'Max',
                        minWidth: 54,
                        size: CpButtonSize.small,
                        variant: CpButtonVariant.inverted,
                      ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: _visibility,
              child: Positioned(
                left: 26,
                bottom: 9,
                child: Text(
                  r'≈ $' + _buildUsdcAmountText,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  String get _buildUsdcAmountText =>
      ((num.tryParse(widget.controller.text) ?? 1) *
              widget.fiatRate.decimal.toDouble())
          .toStringAsFixed(2);

  bool _isMax() =>
      (num.tryParse(
            widget.controller.text,
          ) ??
          -1) ==
      widget.crypto.decimal.toDouble();
}
