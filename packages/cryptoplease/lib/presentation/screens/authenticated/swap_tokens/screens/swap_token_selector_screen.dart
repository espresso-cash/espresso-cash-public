import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/presentation/screens/authenticated/swap_tokens/components/text_search_field.dart';
import 'package:cryptoplease/presentation/screens/authenticated/swap_tokens/components/token_dropdown.dart';
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
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          backgroundColor: CpColors.darkBackground,
          appBar: CpAppBar(
            leading: const CloseButton(),
            title: const Text('Select Token'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: NestedScrollView(
              headerSliverBuilder: (context, _) => [
                SliverToBoxAdapter(
                  child: TextSearchFieldWidget(
                    onClear: _onClear,
                    onSearch: _onSearch,
                  ),
                ),
              ],
              body: ListView.builder(
                itemCount: _tokenList.length,
                itemBuilder: (context, index) => Card(
                  color: CpColors.accentDarkBackground,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TokenMini(
                      extensive: true,
                      token: _tokenList.elementAt(index),
                      onTap: () => Navigator.of(context).pop(
                        _tokenList.elementAt(index),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
