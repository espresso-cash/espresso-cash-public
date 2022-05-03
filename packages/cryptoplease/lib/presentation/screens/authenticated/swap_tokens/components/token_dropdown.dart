import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/presentation/components/token_icon.dart';
import 'package:flutter/material.dart';

class TokenDropdown extends StatefulWidget {
  const TokenDropdown({
    Key? key,
    required this.availableTokens,
    required this.selectedToken,
    required this.onChanged,
  }) : super(key: key);

  final Iterable<Token> availableTokens;
  final Token? selectedToken;
  final ValueSetter<Token> onChanged;

  @override
  _TokenDropdownState createState() => _TokenDropdownState();
}

class _TokenDropdownState extends State<TokenDropdown> {
  Token? currentToken;
  late List<DropdownMenuItem<Token>> tokenList;

  @override
  void initState() {
    super.initState();
    tokenList = List.empty();
    currentToken = widget.selectedToken;
  }

  @override
  void didUpdateWidget(covariant TokenDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.availableTokens != widget.availableTokens) {
      currentToken = null;
      tokenList = widget.availableTokens
          .map(
            (token) => DropdownMenuItem(
              value: token,
              child: _DropdownTokenWidget(token: token),
            ),
          )
          .toList();
    }
  }

  void _selectToken(Token? token) {
    if (token != null) {
      setState(() => currentToken = token);
      widget.onChanged(token);
    }
  }

  @override
  Widget build(BuildContext context) => Material(
        child: DropdownButton<Token>(
          items: tokenList,
          value: currentToken,
          onChanged: _selectToken,
          underline: const SizedBox.shrink(),
        ),
      );
}

class _DropdownTokenWidget extends StatelessWidget {
  const _DropdownTokenWidget({
    Key? key,
    required this.token,
  }) : super(key: key);

  final Token token;

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 16),
          TokenIcon(token: token, size: 24),
          const SizedBox(width: 16),
          Text(
            token.symbol,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      );
}
