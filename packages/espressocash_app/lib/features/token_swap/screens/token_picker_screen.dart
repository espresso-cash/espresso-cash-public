import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/colors.dart';
import '../../../ui/text_field.dart';
import '../../../ui/theme.dart';
import '../../../ui/value_stream_builder.dart';
import '../../balances/data/repository.dart';
import '../../conversion_rates/services/token_fiat_balance_service.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../ramp/widgets/debounce_mixin.dart';
import '../../tokens/data/token_repository.dart';
import '../../tokens/token.dart';
import '../../tokens/widgets/token_icon.dart';

class TokenPickerScreen extends StatelessWidget {
  const TokenPickerScreen({
    super.key,
    this.initial,
    required this.title,
    this.showOnlyUserTokens = false,
  });

  static const popularTokenList = [
    'USDT', // Tether
    'SOL', // Solana
    'USDC', // USD Coin
    'JITOSOL', // Jito Staked SOL
    'USDS', // USDS
    'CBBTC', // Coinbase Wrapped BTC
    'BONK', // Bonk
    'JUP', // Jupiter
    'RAY', // Raydium
  ];

  static Future<Token?> push(
    BuildContext context, {
    Token? initial,
    required String title,
    bool showOnlyUserTokens = false,
  }) => Navigator.of(context).push<Token?>(
    MaterialPageRoute(
      builder:
          (context) => TokenPickerScreen(
            initial: initial,
            title: title,
            showOnlyUserTokens: showOnlyUserTokens,
          ),
    ),
  );

  final Token? initial;
  final String title;
  final bool showOnlyUserTokens;

  @override
  Widget build(BuildContext context) => CpTheme.dark(
    child: Scaffold(
      backgroundColor: CpColors.deepGreyColor,
      appBar: CpAppBar(
        title: Text(title.toUpperCase()),
        leading: const SizedBox(),
        nextButton: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Align(
            alignment: Alignment.centerRight,
            child: Padding(padding: EdgeInsets.only(right: 10.0), child: Icon(Icons.close)),
          ),
        ),
      ),
      body: _Content(initial: initial, showOnlyUserTokens: showOnlyUserTokens),
    ),
  );
}

class _Content extends StatefulWidget {
  const _Content({this.initial, this.showOnlyUserTokens = false});

  final Token? initial;
  final bool showOnlyUserTokens;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> with DebounceMixin {
  late final Future<List<Token>> _tokensFuture;
  final _balanceService = sl<TokenFiatBalanceService>();
  final _tokenRepository = sl<TokenRepository>();

  final TextEditingController _searchController = TextEditingController();

  Token? _selectedToken;
  String _searchText = '';
  List<Token>? _searchResults;

  @override
  void initState() {
    super.initState();
    _selectedToken = widget.initial;

    if (widget.showOnlyUserTokens) {
      _tokensFuture = _fetchUserTokens();
    } else {
      _tokensFuture = _tokenRepository.fetchBySymbols(TokenPickerScreen.popularTokenList);
    }

    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text;
    setState(() => _searchText = query);

    if (!widget.showOnlyUserTokens) {
      if (query.isEmpty) {
        setState(() => _searchResults = null);

        return;
      }

      debounce(() async {
        if (!mounted || query != _searchController.text) return;

        final results = await _tokenRepository.search(query);

        if (!mounted) return;

        setState(() => _searchResults = results);
      });
    }
  }

  Future<List<Token>> _fetchUserTokens() async {
    final tokenBalancesRepository = sl<TokenBalancesRepository>();
    final userTokens = await tokenBalancesRepository.readUserTokens();

    return userTokens.toList();
  }

  List<Token> _filterTokens(List<Token> tokens) {
    final filteredTokens = [...tokens];

    if (_selectedToken != null) {
      final initialIndex = filteredTokens.indexWhere((t) => t.address == _selectedToken?.address);
      if (initialIndex != -1) {
        final initialToken = filteredTokens.removeAt(initialIndex);
        filteredTokens.insert(0, initialToken);
      }
    }

    return widget.showOnlyUserTokens
        ? filteredTokens.where((token) {
          final query = _searchText.toLowerCase();
          final name = token.name.toLowerCase();
          final symbol = token.symbol.toLowerCase();

          if (query.isEmpty) return true;

          return symbol == query || symbol.startsWith(query) || name.startsWith(query)
              ? true
              : symbol.contains(query) || name.contains(query);
        }).toList()
        : (_searchResults ?? filteredTokens);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: CpTextField(
          controller: _searchController,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
          fontSize: 16,
          border: CpTextFieldBorder.stadium,
          placeholder: context.l10n.searchPlaceholder,
          backgroundColor: CpColors.blackGreyColor,
          textColor: Colors.white,
          inputType: TextInputType.text,
          prefix: const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Icon(Icons.search, color: Colors.white),
          ),
        ),
      ),
      Expanded(
        child: FutureBuilder<List<Token>>(
          future: _tokensFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  context.l10n.errorLoadingTokens,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }

            final tokens = snapshot.data ?? [];
            final displayTokens = _filterTokens(tokens);

            return displayTokens.isEmpty
                ? Center(
                  child: Text(
                    context.l10n.noResultsFound,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                )
                : ValueStreamBuilder<IList<CryptoFiatAmount>>(
                  create: () => (_balanceService.watchAllBalances(), const IListConst([])),
                  builder:
                      (context, balances) => ListView.separated(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 20,
                          bottom: MediaQuery.paddingOf(context).bottom,
                        ),
                        itemCount: displayTokens.length,
                        separatorBuilder: (context, index) => const SizedBox(height: _tilePadding),
                        itemBuilder: (BuildContext context, int index) {
                          final token = displayTokens[index];
                          final selected = token.address == _selectedToken?.address;

                          final balance = balances.firstWhere(
                            (b) => b.$1.token.address == token.address,
                            orElse:
                                () => (
                                  CryptoAmount(
                                    value: 0,
                                    cryptoCurrency: CryptoCurrency(token: token),
                                  ),
                                  null,
                                ),
                          );

                          return _TokenItem(
                            key: ValueKey(balance.$1.token),
                            isSelected: selected,
                            cryptoAmount: balance.$1,
                            fiatAmount: balance.$2,
                          );
                        },
                      ),
                );
          },
        ),
      ),
    ],
  );
}

class _TokenItem extends StatelessWidget {
  const _TokenItem({
    super.key,
    required this.cryptoAmount,
    required this.fiatAmount,
    required this.isSelected,
  });

  final CryptoAmount cryptoAmount;
  final FiatAmount? fiatAmount;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final fiatAmountText = context.formatFiatAmount(fiatAmount, _minFiatAmount);

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: ShapeDecoration(
        color: isSelected ? CpColors.blackTextFieldBackgroundColor : CpColors.blackGreyColor,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
      child: ListTile(
        key: key,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        dense: true,
        horizontalTitleGap: 4,
        leading: TokenIcon(token: cryptoAmount.token, size: _iconSize),
        onTap: () => Navigator.pop(context, cryptoAmount.token),
        title: Text(
          cryptoAmount.token.name,
          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              fiatAmountText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              cryptoAmount.format(context.locale),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension FiatAmountExtension on BuildContext {
  String formatFiatAmount(FiatAmount? fiatAmount, num minFiatAmount) {
    if (fiatAmount != null) {
      if (fiatAmount.value < minFiatAmount) {
        return r'<$0.01';
      }

      return fiatAmount.format(locale, maxDecimals: 2);
    }

    return '-';
  }
}

const _tilePadding = 8.0;
const _iconSize = 36.0;

const double _minFiatAmount = 0.01;
