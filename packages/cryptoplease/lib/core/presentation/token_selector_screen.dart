import 'package:cryptoplease/app/components/token_icon.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/balances/presentation/watch_balance.dart';
import 'package:cryptoplease/core/presentation/format_amount.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

class TokenSelectorScreen extends StatefulWidget {
  const TokenSelectorScreen({
    Key? key,
    required this.availableTokens,
    required this.shouldShowBalance,
  }) : super(key: key);

  final Iterable<Token> availableTokens;
  final bool shouldShowBalance;

  @override
  State<TokenSelectorScreen> createState() => _SelectorState();
}

class _SelectorState extends State<TokenSelectorScreen> {
  IList<Token> _otherTokenList = IList();
  IList<Token> _popularTokenList = IList();

  static const _popularTokenSymbols = {'usdc', 'usdt', 'sol', 'btc'};

  @override
  void initState() {
    super.initState();
    _splitTokens();
  }

  void _splitTokens() {
    final tokenSet = widget.availableTokens.toSet();
    _popularTokenList = tokenSet
        .where(
          (token) => _popularTokenSymbols.contains(token.symbol.toLowerCase()),
        )
        .toIList();
    _otherTokenList = tokenSet.difference(_popularTokenList.toSet()).toIList();
  }

  void _onSearch(String text) {
    if (text.isEmpty) {
      setState(_splitTokens);

      return;
    }

    final query = text.toLowerCase();
    bool matches(Token token) =>
        token.name.toLowerCase().contains(query) ||
        token.symbol.toLowerCase().contains(query);

    final filterOthers = _otherTokenList.where(matches).toIList();
    final filterPopular = _popularTokenList.where(matches).toIList();

    setState(() {
      _popularTokenList = filterPopular;
      _otherTokenList = filterOthers;
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
                  if (_popularTokenList.isNotEmpty)
                    const _SectionTitle(title: 'Popular tokens'),
                  _TokenList(
                    tokens: _popularTokenList,
                    onTokenSelected: (token) =>
                        Navigator.of(context).pop(token),
                    shouldDisplayAmount: widget.shouldShowBalance,
                  ),
                  if (_popularTokenList.isNotEmpty)
                    const _SectionTitle(title: 'Other tokens'),
                  _TokenList(
                    tokens: _otherTokenList,
                    onTokenSelected: (token) =>
                        Navigator.of(context).pop(token),
                    shouldDisplayAmount: widget.shouldShowBalance,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      );
}

class _TokenList extends StatelessWidget {
  const _TokenList({
    Key? key,
    required this.tokens,
    required this.onTokenSelected,
    required this.shouldDisplayAmount,
  }) : super(key: key);

  final IList<Token> tokens;
  final ValueSetter<Token> onTokenSelected;
  final bool shouldDisplayAmount;

  @override
  Widget build(BuildContext context) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final token = tokens.elementAt(index);

            return _SelectableBalanceItem(
              token: token,
              onSelect: onTokenSelected,
              balance: shouldDisplayAmount
                  ? context.watchUserCryptoBalance(token)
                  : null,
            );
          },
          childCount: tokens.length,
        ),
      );
}

class _SelectableBalanceItem extends StatelessWidget {
  const _SelectableBalanceItem({
    Key? key,
    required this.token,
    required this.onSelect,
    this.balance,
  }) : super(key: key);

  final Token token;
  final ValueSetter<Token> onSelect;
  final Amount? balance;

  @override
  Widget build(BuildContext context) {
    final locale = DeviceLocale.localeOf(context);
    final balance = this.balance;

    return InkWell(
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
            subtitle: balance == null ? null : Text(balance.format(locale)),
          ),
        ),
      ),
    );
  }
}
