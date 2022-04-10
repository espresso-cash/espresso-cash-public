import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/bl/currency.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/presentation/components/token_fiat_input_widget/add_max_button.dart';
import 'package:cryptoplease/presentation/components/token_fiat_input_widget/amount_display.dart';
import 'package:cryptoplease/presentation/components/token_fiat_input_widget/converted_amount_view.dart';
import 'package:cryptoplease/presentation/components/token_fiat_input_widget/enter_amount_keypad.dart';
import 'package:cryptoplease/presentation/components/token_fiat_input_widget/switch_currency_button.dart';
import 'package:cryptoplease/presentation/format_amount.dart';

import 'package:decimal/decimal.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum _AmountInputType { token, fiat }

class TokenFiatInputWidget extends StatefulWidget {
  const TokenFiatInputWidget({
    Key? key,
    required this.tokenAmount,
    required this.fiatAmount,
    required this.currency,
    required this.onTokenAmountChanged,
    required this.onFiatAmountChanged,
    required this.onTokenChanged,
    required this.availableTokens,
    this.onMaxRequested,
  }) : super(key: key);

  final CryptoAmount tokenAmount;
  final FiatAmount? fiatAmount;
  final Currency currency;
  final ValueSetter<Decimal> onTokenAmountChanged;
  final ValueSetter<Decimal> onFiatAmountChanged;
  final ValueSetter<Token> onTokenChanged;
  final VoidCallback? onMaxRequested;
  final IList<Token> availableTokens;

  @override
  _TokenFiatSwitcherInputState createState() => _TokenFiatSwitcherInputState();
}

class _TokenFiatSwitcherInputState extends State<TokenFiatInputWidget> {
  late final TextEditingController _controller;
  late _AmountInputType _inputType;

  @override
  void initState() {
    super.initState();
    _inputType = _AmountInputType.token;
    _controller = TextEditingController.fromValue(TextEditingValue.empty);
    _controller.addListener(_calculateAmount);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant TokenFiatInputWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    final amount = _inputType == _AmountInputType.token
        ? widget.tokenAmount
        : widget.fiatAmount;
    if (amount != null && amount.decimal != _decimalValue) {
      _refreshFromWidget(amount);
    }
  }

  void _refreshFromWidget(Amount amount) {
    _controller.text = amount.format(
      DeviceLocale.localeOf(context),
      skipSymbol: true,
    );
  }

  Decimal get _decimalValue =>
      _controller.text.toDecimalOrZero(DeviceLocale.localeOf(context));

  void _calculateAmount() {
    if (_inputType == _AmountInputType.token) {
      widget.onTokenAmountChanged(_decimalValue);
    } else {
      widget.onFiatAmountChanged(_decimalValue);
    }
  }

  void _onCurrencySwitch() {
    final newInput = _inputType == _AmountInputType.token
        ? _AmountInputType.fiat
        : _AmountInputType.token;
    setState(() => _inputType = newInput);
    final amount = _inputType == _AmountInputType.token
        ? widget.tokenAmount
        : widget.fiatAmount;
    _controller.text = amount == null || amount.value == 0
        ? ''
        : amount.format(DeviceLocale.localeOf(context), skipSymbol: true);
  }

  int get _maxDecimals {
    switch (_inputType) {
      case _AmountInputType.token:
        return widget.tokenAmount.currency.decimals;
      case _AmountInputType.fiat:
        return widget.currency.decimals;
    }
  }

  @override
  Widget build(BuildContext context) {
    final onMaxRequested = widget.onMaxRequested;

    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 64),
              child: Column(
                children: [
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _controller,
                    builder: (context, value, _) => AmountDisplay(
                      value: value.text,
                      onTokenChanged: _inputType == _AmountInputType.token
                          ? widget.onTokenChanged
                          : null,
                      currency: _inputType == _AmountInputType.token
                          ? widget.tokenAmount.currency
                          : widget.currency,
                      availableTokens: widget.availableTokens,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (widget.fiatAmount != null)
                    ConvertedAmountView(
                      amount: _inputType == _AmountInputType.token
                          ? widget.fiatAmount
                          : widget.tokenAmount,
                    ),
                ],
              ),
            ),
            if (widget.fiatAmount != null)
              Positioned(
                bottom: 0,
                right: 16,
                top: 24,
                child: Flex(
                  mainAxisAlignment: MainAxisAlignment.center,
                  direction: Axis.vertical,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SwitchCurrencyButton(onTap: _onCurrencySwitch),
                  ],
                ),
              )
          ],
        ),
        const SizedBox(height: 36),
        if (onMaxRequested != null)
          AddMaxButton(
            token: widget.tokenAmount.token,
            onPressed: onMaxRequested,
          ),
        EnterAmountKeypad(
          controller: _controller,
          maxDecimals: _maxDecimals,
        ),
      ],
    );
  }
}

extension on String {
  Decimal toDecimalOrZero(Locale locale) {
    try {
      final formatter = NumberFormat.decimalPattern(locale.languageCode)
        ..minimumFractionDigits = 2;
      final formatted = formatter.parse(this);

      return Decimal.tryParse(formatted.toString()) ?? Decimal.zero;
    } on FormatException catch (_) {
      return Decimal.zero;
    }
  }
}
