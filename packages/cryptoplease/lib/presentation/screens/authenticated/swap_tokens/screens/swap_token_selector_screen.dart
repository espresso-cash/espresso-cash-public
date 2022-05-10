import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/presentation/components/token_fiat_input_widget/token_list_dialog/token_item.dart';
import 'package:cryptoplease/presentation/screens/authenticated/swap_tokens/components/text_search_field.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class SwapTokenSelectorScreen extends StatefulWidget {
  const SwapTokenSelectorScreen({
    Key? key,
    required this.availableTokens,
  }) : super(key: key);

  final Iterable<Token> availableTokens;

  @override
  State<SwapTokenSelectorScreen> createState() => _SelectorState();
}

class _SelectorState extends State<SwapTokenSelectorScreen> {
  late Iterable<Token> _tokenList;

  @override
  void initState() {
    super.initState();
    _tokenList = widget.availableTokens;
  }

  void _onClear() => setState(() => _tokenList = widget.availableTokens);

  void _onSearch(String text) {
    final query = text.toLowerCase();
    final filtered = widget.availableTokens.where(
      (token) => token.name.toLowerCase().contains(query),
    );
    setState(() => _tokenList = filtered);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CpAppBar(
          leading: const CloseButton(),
          title: const Text('Select Token'),
        ),
        body: Column(
          children: [
            TextSearchFieldWidget(
              onClear: _onClear,
              onSearch: _onSearch,
            ),
            // TODO(rhbrunetto): bit laggy, need to improve
            Expanded(
              child: ListView.builder(
                itemCount: _tokenList.length,
                itemBuilder: (context, index) => TokenItem(
                  token: _tokenList.elementAt(index),
                  onSelected: (token) => Navigator.of(context).pop(token),
                ),
              ),
            ),
          ],
        ),
      );
}
