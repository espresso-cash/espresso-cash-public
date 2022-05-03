import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/presentation/screens/authenticated/swap_tokens/components/token_dropdown.dart';
import 'package:flutter/material.dart';

class TokenSwitcherHeader extends StatelessWidget {
  TokenSwitcherHeader({
    Key? key,
    required this.inputTokens,
    required this.outputTokens,
    required this.selectedInputToken,
    required this.selectedOutputToken,
    required this.onInputSelected,
    required this.onOutputSelected,
  }) : super(key: key);

  final Iterable<Token> inputTokens;
  final Iterable<Token> outputTokens;
  final Token? selectedInputToken;
  final Token? selectedOutputToken;
  final ValueSetter<Token> onInputSelected;
  final ValueSetter<Token> onOutputSelected;

  final _inputKey = GlobalKey();
  final _outputKey = GlobalKey();

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: TokenDropdown(
              key: _inputKey,
              availableTokens: inputTokens,
              selectedToken: selectedInputToken,
              onChanged: onInputSelected,
            ),
          ),
          const SizedBox.square(dimension: 16),
          const Text('to'),
          const SizedBox.square(dimension: 16),
          Flexible(
            child: TokenDropdown(
              key: _outputKey,
              availableTokens: outputTokens,
              selectedToken: selectedOutputToken,
              onChanged: onOutputSelected,
            ),
          ),
        ],
      );
}
