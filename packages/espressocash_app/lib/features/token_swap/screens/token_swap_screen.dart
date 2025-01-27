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
import '../../../ui/text_field.dart';
import '../../../ui/theme.dart';
import '../../../ui/value_stream_builder.dart';
import '../../conversion_rates/data/repository.dart';
import '../../conversion_rates/services/token_fiat_balance_service.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../tokens/token.dart';
import '../widgets/token_picker.dart';

class TokenSwapScreen extends StatefulWidget {
  const TokenSwapScreen({super.key, required this.token});

  static void push(BuildContext context, {required Token token}) =>
      Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => TokenSwapScreen(token: token),
        ),
      );

  final Token token;

  @override
  State<TokenSwapScreen> createState() => _TokenSwapScreenState();
}

class _TokenSwapScreenState extends State<TokenSwapScreen> {
  final _quantityPayController = TextEditingController();
  final _quantityReceiveController = TextEditingController();

  late Token _receiveToken;
  late Token _payToken;

  late Decimal _payTokenRate = Decimal.fromInt(0);
  late Decimal _receiveTokenRate = Decimal.fromInt(0);

  double _amountInputWidth = 180;
  double _symbolInputWidth = 180;

  bool _isPayAmountChanging = false;
  bool _isReceiveAmountChanging = false;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _payToken = widget.token;
    _receiveToken = Token.usdc;

    _updateRate(widget.token, Token.usdc);

    _quantityPayController.addListener(_onPayAmountChanged);
    _quantityReceiveController.addListener(_onReceiveAmountChanged);
  }

  @override
  void dispose() {
    _quantityPayController.dispose();
    _quantityReceiveController.dispose();
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
    if (_quantityPayController.text.isEmpty) {
      setState(() {
        _amountInputWidth = 180;
        _symbolInputWidth = 180;
        _isExpanded = false;
      });
      _quantityReceiveController.text = '';

      return;
    }

    _isPayAmountChanging = true;

    final payAmount =
        Decimal.tryParse(_quantityPayController.text) ?? Decimal.zero;
    final receiveAmount = payAmount * _payTokenRate;
    _quantityReceiveController.text = receiveAmount.round(scale: 2).toString();

    setState(() {
      _amountInputWidth = 260;
      _symbolInputWidth = 100;
      _isExpanded = true;
    });

    _isPayAmountChanging = false;
  }

  void _onReceiveAmountChanged() {
    if (_isPayAmountChanging) return;
    if (_quantityReceiveController.text.isEmpty) {
      setState(() {
        _amountInputWidth = 180;
        _symbolInputWidth = 180;
        _isExpanded = false;
      });
      _quantityPayController.text = '';

      return;
    }

    _isReceiveAmountChanging = true;

    final receiveAmount =
        Decimal.tryParse(_quantityReceiveController.text) ?? Decimal.zero;

    final payAmount = receiveAmount / _payTokenRate;
    _quantityPayController.text = payAmount.toDouble().toStringAsFixed(2);

    setState(() {
      _amountInputWidth = 260;
      _symbolInputWidth = 100;
      _isExpanded = true;
    });

    _isReceiveAmountChanging = false;
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
                                  child: _TokenQuantityInput(
                                    quantityController: _quantityPayController,
                                    crypto: crypto,
                                    symbol: _payToken.symbol,
                                    fiatRate: fiatRatePay,
                                    maxButton: false,
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
                                  child: _TokenQuantityInput(
                                    quantityController:
                                        _quantityReceiveController,
                                    crypto: crypto,
                                    symbol: _receiveToken.symbol,
                                    fiatRate: fiatRateReceive,
                                    maxButton: false,
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
                          controller: TextEditingController(),
                          maxDecimals: 4,
                        ),
                      ),
                      const SizedBox(height: 16),
                      CpBottomButton(
                        text: 'Review Swap',
                        onPressed: () {},
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

class _TokenQuantityInput extends StatefulWidget {
  const _TokenQuantityInput({
    required this.quantityController,
    required this.crypto,
    required this.symbol,
    required this.maxButton,
    required this.fiatRate,
  });

  final TextEditingController quantityController;
  final CryptoAmount crypto;
  final String symbol;
  final Amount fiatRate;
  final bool maxButton;

  @override
  State<_TokenQuantityInput> createState() => __TokenQuantityInputState();
}

class __TokenQuantityInputState extends State<_TokenQuantityInput> {
  bool _visibility = false;
  double _textHeight = 1.2;
  double _fontSize = 34.0;

  @override
  void initState() {
    super.initState();
    widget.quantityController.addListener(
      _quantityListener,
    );
  }

  void _quantityListener() {
    final isValueValid = widget.quantityController.text.isNotEmpty;

    setState(() {
      if (isValueValid) {
        _textHeight = 0.9;
        _visibility = true;
      } else {
        _textHeight = 1.2;
        _visibility = false;
      }

      _fontSize = _calculateFontSize(widget.quantityController.text);
    });
  }

  // void _quantityListener2() {
  //   _fontSize = _calculateFontSize(widget.quantityController.text);
  // }

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
  Widget build(BuildContext context) => Stack(
        children: [
          CpTextField(
            padding: const EdgeInsets.only(
              top: 16,
              bottom: 20,
              left: 24,
              right: 24,
            ),
            height: 72,
            controller: widget.quantityController,
            inputType: TextInputType.number,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.none,
            backgroundColor: CpColors.blackGreyColor,
            placeholder: '0 ${widget.maxButton ? widget.symbol : ''}',
            placeholderColor: Colors.white,
            textColor: Colors.white,
            fontSize: _fontSize,
            fontWeight: FontWeight.w700,
            maxLength: 30,
            textHeight: _textHeight,
            suffix: widget.maxButton
                ? Padding(
                    padding: const EdgeInsets.only(right: 14),
                    child: CpButton(
                      onPressed: _isMax()
                          ? () => widget.quantityController.text = ''
                          : () => widget.quantityController.text =
                              '${widget.crypto.decimal}',
                      text: _isMax() ? 'Clear' : 'Max',
                      minWidth: 54,
                      size: CpButtonSize.small,
                      variant: CpButtonVariant.inverted,
                    ),
                  )
                : null,
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
      );

  String get _buildUsdcAmountText =>
      ((num.tryParse(widget.quantityController.text) ?? 1) *
              widget.fiatRate.decimal.toDouble())
          .toStringAsFixed(2);

  bool _isMax() =>
      (num.tryParse(
            widget.quantityController.text,
          ) ??
          -1) ==
      widget.crypto.decimal.toDouble();
}
