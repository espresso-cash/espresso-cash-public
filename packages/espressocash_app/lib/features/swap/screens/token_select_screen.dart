import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/colors.dart';
import '../../../ui/text_field.dart';
import '../../../ui/theme.dart';
import '../../../ui/value_stream_builder.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../currency/models/amount.dart';
import '../../tokens/token.dart';
import '../../tokens/token_list.dart';
import '../../tokens/widgets/token_icon.dart';
import 'swap_screen.dart';

class SwapTokenSelectScreen extends StatelessWidget {
  const SwapTokenSelectScreen({
    super.key,
    required this.type,
    required this.inputToken,
  });

  static Future<Token?> push(
    BuildContext context, {
    required SwapType type,
    required Token inputToken,
  }) =>
      Navigator.of(context).push<Token?>(
        MaterialPageRoute(
          builder: (context) => SwapTokenSelectScreen(
            type: type,
            inputToken: inputToken,
          ),
        ),
      );

  final SwapType type;
  final Token inputToken;

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          appBar: CpAppBar(
            title: Text(
              switch (type) {
                SwapType.input => 'You Pay',
                SwapType.output => 'You Receive',
              }
                  .toUpperCase(),
            ),
          ),
          body: SafeArea(
            child: _TokenSelectContent(
              type: type,
              inputToken: inputToken,
            ),
          ),
        ),
      );
}

class _TokenSelectContent extends StatefulWidget {
  const _TokenSelectContent({
    required this.type,
    required this.inputToken,
  });

  final SwapType type;
  final Token inputToken;

  @override
  State<_TokenSelectContent> createState() => __TokenSelectContentState();
}

class __TokenSelectContentState extends State<_TokenSelectContent> {
  final TextEditingController _searchController = TextEditingController();

  late List<Token> _filteredTokens;

  List<Token> _getTokens() => widget.type == SwapType.output
      ? sl<TokenList>().tokens.where((e) => e != widget.inputToken).toList()
      : [
          Token.sol,
          Token.usdc,
        ]; //TODO fetch from user token list

  @override
  void initState() {
    super.initState();

    _filteredTokens = _getTokens();
    _searchController.addListener(_filterTokens);
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_filterTokens)
      ..dispose();
    super.dispose();
  }

  void _filterTokens() {
    setState(() {
      _filteredTokens =
          _getTokens().filterTokens(_searchController.text).toList();
    });
  }

  void _onTokenSelected(Token token) {
    Navigator.of(context).pop(token);
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          CpTextField(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            controller: _searchController,
            backgroundColor: CpColors.darkBackgroundColor,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            fontSize: 16,
            border: CpTextFieldBorder.stadium,
            placeholder: context.l10n.searchPlaceholder,
            textColor: Colors.white,
            inputType: TextInputType.text,
            prefix: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          if (_filteredTokens.isEmpty)
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    context.l10n.noResultsFound,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            )
          else
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                separatorBuilder: (context, index) => const SizedBox(height: 6),
                itemBuilder: (context, index) {
                  final token = _filteredTokens[index];

                  return _TokenItem(
                    token: token,
                    amount: Amount.fromToken(value: 0, token: token)
                        as CryptoAmount,
                    onTap: () => _onTokenSelected(token),
                  );
                },
                itemCount: _filteredTokens.length,
              ),
            ),
        ],
      );
}

class _TokenItem extends StatelessWidget {
  //TODO update when token list is merged
  const _TokenItem({
    required this.token,
    required this.amount,
    required this.onTap,
  });

  final Token token;
  final CryptoAmount amount;
  final VoidCallback onTap;

  static const double _iconSize = 36.0;
  static const double _minFiatAmount = 0.01;

  @override
  Widget build(BuildContext context) => ValueStreamBuilder<Amount?>(
        // create: () => sl<WatchTokenFiatBalance>().call(token),
        create: () => (
          const Stream.empty(),
          null,
        ),
        builder: (context, fiatAmount) {
          String fiatAmountText;

          if (fiatAmount != null) {
            fiatAmountText = fiatAmount.value < _minFiatAmount
                ? r'<$0.01'
                : fiatAmount.format(context.locale, maxDecimals: 2);
          } else {
            fiatAmountText = '-';
          }

          return _Card(
            child: ListTile(
              key: key,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              dense: true,
              onTap: onTap,
              horizontalTitleGap: 4,
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(_iconSize / 2),
                child: TokenIcon(token: token, size: _iconSize),
              ),
              title: Text(
                token.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
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
                    amount.format(context.locale),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              // isThreeLine: true,
            ),
          );
        },
      );
}

class _Card extends StatelessWidget {
  const _Card({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(4),
        decoration: const ShapeDecoration(
          color: CpColors.darkBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        child: child,
      );
}
