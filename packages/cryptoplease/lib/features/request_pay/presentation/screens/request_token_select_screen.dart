import 'package:cryptoplease/app/components/token_icon.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

class RequestTokenSelectScreen extends StatefulWidget {
  const RequestTokenSelectScreen({
    Key? key,
    required this.availableTokens,
  }) : super(key: key);

  final Iterable<Token> availableTokens;

  @override
  State<RequestTokenSelectScreen> createState() => _SelectorState();
}

class _SelectorState extends State<RequestTokenSelectScreen> {
  late IList<Token> _tokens;

  @override
  void initState() {
    super.initState();
    _resetList();
  }

  void _resetList() {
    _tokens = widget.availableTokens.toIList();
  }

  void _onSearch(String text) {
    if (text.isEmpty) {
      setState(_resetList);

      return;
    }

    final query = text.toLowerCase();
    bool matches(Token token) =>
        token.name.toLowerCase().contains(query) ||
        token.symbol.toLowerCase().contains(query);

    final filter = widget.availableTokens.where(matches).toIList();

    setState(() {
      _tokens = filter;
    });
  }

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          backgroundColor: CpColors.darkBackground,
          appBar: CpAppBar(
            title: Text(context.l10n.selectToken),
            leading: const CloseButton(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: NestedScrollView(
              headerSliverBuilder: (context, _) => [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: CpSearchTextField(
                      label: context.l10n.search,
                      onSearch: _onSearch,
                      variant: CpSearchTextVariant.dark,
                    ),
                  ),
                ),
              ],
              body: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final token = _tokens.elementAt(index);

                        return _TokenItem(
                          token: token,
                          onSelect: (token) => Navigator.of(context).pop(token),
                        );
                      },
                      childCount: _tokens.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class _TokenItem extends StatelessWidget {
  const _TokenItem({
    Key? key,
    required this.token,
    required this.onSelect,
  }) : super(key: key);

  final Token token;
  final ValueSetter<Token> onSelect;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => onSelect(token),
        child: Card(
          color: CpColors.accentDarkBackground,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: TokenIcon(size: 40, token: token),
              title: Text(
                token.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      );
}
