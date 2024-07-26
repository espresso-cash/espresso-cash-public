import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/text_field.dart';
import '../../currency/models/amount.dart';

class TokenQuantityInput extends StatefulWidget {
  const TokenQuantityInput({
    super.key,
    required TextEditingController quantityController,
    required this.crypto,
    required this.rate,
    required this.symbol,
  }) : _quantityController = quantityController;

  final TextEditingController _quantityController;
  final CryptoAmount crypto;
  final String symbol;
  final Decimal rate;

  @override
  State<TokenQuantityInput> createState() => _TokenQuantityInputState();
}

class _TokenQuantityInputState extends State<TokenQuantityInput> {
  bool _visibility = false;
  double _textHeight = 1.2;

  @override
  void initState() {
    super.initState();
    widget._quantityController.addListener(_quantityListener);
  }

  void _quantityListener() {
    final isValueValid = widget._quantityController.text.isNotEmpty;

    setState(() {
      if (isValueValid) {
        _textHeight = 0.9;
        _visibility = true;
      } else {
        _textHeight = 1.2;
        _visibility = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          CpTextField(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 24,
            ),
            height: 72,
            controller: widget._quantityController,
            inputType: TextInputType.number,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.none,
            backgroundColor: CpColors.darkBackgroundColor,
            placeholder: '0 ${widget.symbol}',
            placeholderColor: Colors.white,
            textColor: Colors.white,
            fontSize: 34,
            fontWeight: FontWeight.w700,
            maxLength: 29,
            textHeight: _textHeight,
            suffix: Padding(
              padding: const EdgeInsets.only(right: 14),
              child: CpButton(
                onPressed: _isMaxAmountZero ? _callback : null,
                text: _buttonText,
                fontSize: 12,
                minWidth: 54,
                size: CpButtonSize.small,
                variant: CpButtonVariant.inverted,
              ),
            ),
          ),
          Visibility(
            visible: _visibility,
            child: Positioned(
              left: 26,
              bottom: 7,
              child: Text(
                _usdcAmount,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      );

  num get _parseAmount => num.tryParse(widget._quantityController.text) ?? 0;

  bool get _isMax => _parseAmount == widget.crypto.decimal.toDouble();

  bool get _isMaxAmountZero => widget.crypto.decimal.toDouble() > 0;

  String get _usdcAmount =>
      r'≈ $' + (_parseAmount * widget.rate.toDouble()).toStringAsFixed(2);

  String get _buttonText => _isMax ? 'Clear' : 'Max';

  VoidCallback get _callback => _isMax
      ? () => widget._quantityController.clear()
      : () => widget._quantityController.text = '${widget.crypto.decimal}';
}
