import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/text_field.dart';
import '../../../ui/theme.dart';
import '../../../ui/value_stream_builder.dart';
import '../../app_lock/widgets/pin_keypad.dart';
import '../../conversion_rates/data/repository.dart';
import '../../conversion_rates/services/token_fiat_balance_service.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../token_details/widgets/loader_wrapper.dart';
import '../../tokens/token.dart';
import 'token_picker_screen.dart';

class SwapTokenScreen extends StatefulWidget {
  const SwapTokenScreen({super.key, required this.token});

  static void push(BuildContext context, {required Token token}) =>
      Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => SwapTokenScreen(token: token),
        ),
      );

  final Token token;

  @override
  State<SwapTokenScreen> createState() => _SwapTokenScreenState();
}

class _SwapTokenScreenState extends State<SwapTokenScreen> {
  final TextEditingController _quantityPayController = TextEditingController();
  final TextEditingController _quantityReveiveController =
      TextEditingController();
  double inputAmount = 0;
  double textHeight = 1.2;
  bool visibility = false;
  bool _isPayAmountChanging = false;
  bool _isReceiveAmountChanging = false;
  late Decimal rate = Decimal.fromInt(0);
  double f1Width = 180;
  double f2Width = 180;
  double f3Width = 180;
  double f4Width = 180;
  bool isExpanded = false;

  Token recieveToken = Token.usdc;
  late Token payToken;

  @override
  void initState() {
    super.initState();
    payToken = widget.token;

    _updateRate(widget.token);

    _quantityPayController.addListener(_onPayAmountChanged);
    _quantityReveiveController.addListener(_onReceiveAmountChanged);
  }

  Future<void> _updateRate(Token token) async {
    await sl<ConversionRatesRepository>()
        .refresh(defaultFiatCurrency, [payToken, recieveToken]);
    rate = sl<ConversionRatesRepository>().readRate(
          CryptoCurrency(token: token),
          to: defaultFiatCurrency,
        ) ??
        Decimal.zero;
  }

  void _onPayAmountChanged() {
    if (_isReceiveAmountChanging) return;
    if (_quantityPayController.text.isEmpty) {
      setState(() {
        f1Width = 180;
        f3Width = 180;
        f2Width = 180;
        f4Width = 180;
        isExpanded = false;
      });
      _quantityReveiveController.text = '';
      return;
    }

    _isPayAmountChanging = true;

    final payAmount =
        Decimal.tryParse(_quantityPayController.text) ?? Decimal.zero;
    final receiveAmount = payAmount * rate;
    _quantityReveiveController.text = receiveAmount.round(scale: 2).toString();

    setState(() {
      f1Width = 260;
      f3Width = 260;
      f2Width = 100;
      f4Width = 100;
      isExpanded = true;
    });

    _isPayAmountChanging = false;
  }

  void _onReceiveAmountChanged() {
    if (_isPayAmountChanging) return;
    if (_quantityReveiveController.text.isEmpty) {
      setState(() {
        f1Width = 180;
        f3Width = 180;
        f2Width = 180;
        f4Width = 180;
        isExpanded = false;
      });
      _quantityPayController.text = '';
      return;
    }

    _isReceiveAmountChanging = true;

    final receiveAmount =
        Decimal.tryParse(_quantityReveiveController.text) ?? Decimal.zero;
    final payAmount = receiveAmount / rate;
    _quantityPayController.text = payAmount.toDouble().toStringAsFixed(2);

    setState(() {
      f1Width = 260;
      f3Width = 260;
      f2Width = 100;
      f4Width = 100;
      isExpanded = true;
    });

    _isReceiveAmountChanging = false;
  }

  @override
  Widget build(BuildContext context) => LoadBalancesWrapper(
        builder: (context, onRefresh) {
          onRefresh();
          return ValueStreamBuilder<CryptoFiatAmount>(
            create: () => (
              sl<TokenFiatBalanceService>().readInvestmentBalance(widget.token),
              (
                Amount.zero(currency: Currency.usdc) as CryptoAmount,
                Amount.zero(currency: Currency.usd) as FiatAmount
              )
            ),
            builder: (context, value) {
              final crypto = value.$1;

              final fiatRate =
                  Amount.fromDecimal(value: rate, currency: Currency.usd);

              return Provider<Token>.value(
                value: widget.token,
                child: CpTheme.dark(
                  child: Scaffold(
                    appBar: CpAppBar(
                      title: Text(context.l10n.swap),
                    ),
                    backgroundColor: CpColors.dashboardBackgroundColor,
                    body: SafeArea(
                      bottom: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 23.0),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AnimatedContainer(
                                      curve: Curves.easeInOut,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      width: f1Width,
                                      child: _TokenQuantityInput(
                                        quantityController:
                                            _quantityPayController,
                                        crypto: crypto,
                                        symbol: widget.token.symbol,
                                        fiatRate: fiatRate,
                                        maxButton: true,
                                      ),
                                    ),
                                    AnimatedContainer(
                                      curve: Curves.easeInOut,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      width: f2Width,
                                      child: TokenPicker(
                                        title: 'You Pay',
                                        onSubmitted: (value) async {
                                          await _updateRate(value);
                                          setState(() {
                                            payToken = value;
                                          });
                                        },
                                        token: payToken,
                                        size: !isExpanded
                                            ? TokenPickerSize.big
                                            : TokenPickerSize.small,
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
                                  color: CpColors.darkBackground,
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 23.0),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AnimatedContainer(
                                      curve: Curves.easeInOut,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      width: f3Width,
                                      child: _TokenQuantityInput(
                                        quantityController:
                                            _quantityReveiveController,
                                        crypto: crypto,
                                        symbol: Token.usdc.symbol,
                                        fiatRate: Amount.fromDecimal(
                                          value: Decimal.tryParse('1')!,
                                          currency: Currency.usdc,
                                        ),
                                        maxButton: false,
                                      ),
                                    ),
                                    AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      width: f4Width,
                                      child: TokenPicker(
                                        title: 'You Receive',
                                        token: recieveToken,
                                        onSubmitted: (value) async {
                                          await _updateRate(value);
                                          setState(() {
                                            recieveToken = value;
                                          });
                                        },
                                        size: !isExpanded
                                            ? TokenPickerSize.big
                                            : TokenPickerSize.small,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          PinKeypad(
                            maxDigits: 30,
                            controller: TextEditingController(),
                            heightFactor: 0.415,
                            hasDacimalSeparator: true,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 45.0),
                            child: CpButton(
                              width: MediaQuery.sizeOf(context).width,
                              alignment: CpButtonAlignment.center,
                              size: CpButtonSize.big,
                              onPressed: () {},
                              text: 'Review Swap',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      );
}

enum TokenPickerSize {
  small,
  big,
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
            backgroundColor: CpColors.darkBackgroundColor,
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
                      fontSize: 12,
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
                r'≈ $' + buildUsdcAmountText,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      );

  String get buildUsdcAmountText =>
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
