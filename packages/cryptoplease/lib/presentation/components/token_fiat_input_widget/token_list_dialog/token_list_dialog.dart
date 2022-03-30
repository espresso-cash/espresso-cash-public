import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/token_fiat_input_widget/token_list_dialog/search_box.dart';
import 'package:cryptoplease/presentation/components/token_fiat_input_widget/token_list_dialog/token_item.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class TokenListDialog extends StatefulWidget {
  const TokenListDialog({
    Key? key,
    required this.tokens,
    required this.onTokenSelected,
  }) : super(key: key);

  final ValueSetter<Token> onTokenSelected;
  final List<Token> tokens;

  @override
  State<TokenListDialog> createState() => _TokenListDialogState();
}

class _TokenListDialogState extends State<TokenListDialog> {
  final TextEditingController _controller = TextEditingController();
  List<Token> tokens = [];

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller.addListener(_onSearch);
    tokens = widget.tokens;
  }

  void _onSearch() {
    setState(() {
      tokens = widget.tokens.filterByKeyword(_controller.text);
    });
  }

  void _close() {
    Navigator.of(context, rootNavigator: true).pop();
  }

  void _onTokenSelected(Token token) {
    widget.onTokenSelected(token);
    _close();
  }

  @override
  Widget build(BuildContext context) => CpTheme.light(
        child: Dialog(
          child: Column(
            children: [
              SearchBox(controller: _controller),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (_, int index) => TokenItem(
                    token: tokens[index],
                    onSelected: _onTokenSelected,
                  ),
                  itemCount: tokens.length,
                  separatorBuilder: (context, index) => const Divider(
                    color: CpColors.listDividerColor,
                    height: 0,
                  ),
                ),
              ),
              TextButton(
                onPressed: _close,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 0),
                  padding: const EdgeInsets.all(16),
                  textStyle: Theme.of(context).textTheme.button?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: CpColors.primaryColor,
                      ),
                ),
                child: Text(context.l10n.cancel.toUpperCase()),
              ),
            ],
          ),
        ),
      );
}

extension on String {
  String get normalized => toLowerCase();

  bool caseInsensitiveContains(String other) =>
      normalized.contains(other.normalized);
}

extension on Token {
  bool symbolIncludes(String keyword) =>
      symbol.caseInsensitiveContains(keyword);
}

extension on List<Token> {
  List<Token> filterByKeyword(String keyword) {
    if (keyword.isEmpty) {
      return this;
    } else {
      final result =
          where((t) => t.symbolIncludes(keyword)).toList(growable: false);

      return result;
    }
  }
}
