import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/presentation/components/token_fiat_input_widget/token_list_dialog/token_item.dart';
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
      tokenList = widget.availableTokens
          .map(
            (token) => DropdownMenuItem(
              value: token,
              child: SizedBox(
                height: 120,
                width: 320,
                child: TokenItem(token: token),
              ),
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
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: DropdownButton<Token>(
            items: tokenList,
            value: currentToken,
            onChanged: _selectToken,
            underline: const SizedBox.shrink(),
          ),
        ),
      );
}
