import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/colors.dart';
import '../../../ui/text_field.dart';
import '../../../ui/theme.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../tokens/token.dart';
import '../../tokens/token_list.dart';
import '../../tokens/widgets/token_icon.dart';
import 'swap_token_screen.dart';

class TokenPicker extends StatelessWidget {
  const TokenPicker({
    super.key,
    this.token,
    required this.title,
    required this.onSubmitted,
    this.size = TokenPickerSize.big,
  });

  final Token? token;
  final String title;
  final ValueSetter<Token> onSubmitted;
  final TokenPickerSize size;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: const ShapeDecoration(
          color: CpColors.darkBackgroundColor,
          shape: StadiumBorder(),
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
          onTap: () async {
            final Token? updated = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    TokenPickerScreen(initial: token, title: title),
              ),
            );

            if (context.mounted && updated != null) {
              onSubmitted(updated);
            }
          },
          leading: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            child: token?.logoURI != null
                // ignore: avoid-non-null-assertion, can not be null
                ? CachedNetworkImage(imageUrl: token!.logoURI!)
                : const _DefaultIcon(
                    size: 42,
                  ),
          ),
          title: SizedBox(
            height: 28,
            child: Text(
              size == TokenPickerSize.big
                  ? (token?.symbol ?? Token.usdc.symbol)
                  : '',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.white,
                height: 1.5,
                overflow: TextOverflow.fade,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          titleAlignment: ListTileTitleAlignment.threeLine,
          trailing: const Icon(
            Icons.keyboard_arrow_down_outlined,
            color: Colors.white,
            size: 30,
          ),
        ),
      );
}

class TokenPickerScreen extends StatelessWidget {
  const TokenPickerScreen({
    super.key,
    this.initial,
    required this.title,
  });

  final Token? initial;
  final String title;

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          backgroundColor: CpColors.darkBackground,
          appBar: CpAppBar(
            title: Text(title.toUpperCase()),
            leading: const SizedBox(),
            nextButton: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(Icons.close),
                ),
              ),
            ),
          ),
          body: const _Content(initial: Token.usdc),
        ),
      );
}

class _Content extends StatefulWidget {
  const _Content({this.initial});

  final Token? initial;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  Token? _selectedToken;
  String _searchText = '';
  final _tokens = TokenList().tokens.toList();

  @override
  void initState() {
    super.initState();

    _selectedToken = widget.initial;

    _searchController.addListener(() {
      setState(() => _searchText = _searchController.text);
    });

    final token = _selectedToken;

    if (token != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final index = _tokens.indexOf(token);
        final centerOffset = ((context.size?.height ?? 0) - _tileHeight) / 2.5;
        final offset = index * _tileHeight - centerOffset;
        _scrollController.jumpTo(offset);
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredCountries = _tokens.where((token) {
      final nameMatches =
          token.name.toLowerCase().contains(_searchText.toLowerCase());

      final codeMatches =
          token.address.toLowerCase().contains(_searchText.toLowerCase());

      return nameMatches || codeMatches;
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: CpTextField(
            controller: _searchController,
            padding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 14.75),
            fontSize: 16,
            border: CpTextFieldBorder.stadium,
            placeholder: context.l10n.searchPlaceholder,
            backgroundColor: CpColors.darkBackgroundColor,
            textColor: Colors.white,
            inputType: TextInputType.text,
            prefix: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ),
        if (filteredCountries.isEmpty)
          Expanded(
            child: Center(
              child: Text(
                context.l10n.noResultsFound,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          )
        else
          Expanded(
            child: ListView.separated(
              controller: _scrollController,
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.paddingOf(context).bottom,
              ),
              itemCount: filteredCountries.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (BuildContext context, int index) {
                final token = filteredCountries[index];
                final selected = token == _selectedToken;

                return DecoratedBox(
                  decoration: selected
                      ? const ShapeDecoration(
                          color: CpColors.blackTextFieldBackgroundColor,
                          shape: StadiumBorder(),
                        )
                      : const BoxDecoration(),
                  child: _TokenItem(
                    cryptoAmount: CryptoAmount(
                      value: 0,
                      cryptoCurrency: CryptoCurrency(token: token),
                    ),
                    fiatAmount: const FiatAmount(
                      value: 0,
                      fiatCurrency: defaultFiatCurrency,
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

const _tileHeight = 46.0;

class _TokenItem extends StatelessWidget {
  const _TokenItem({
    super.key,
    required this.cryptoAmount,
    required this.fiatAmount,
  });

  final CryptoAmount cryptoAmount;
  final FiatAmount fiatAmount;

  static const double _iconSize = 36.0;
  static const double _minFiatAmount = 0.01;

  @override
  Widget build(BuildContext context) {
    String fiatAmountText;

    fiatAmountText = fiatAmount.value < _minFiatAmount
        ? r''
        : fiatAmount.format(context.locale, maxDecimals: 2);

    return _Card(
      child: ListTile(
        key: key,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        dense: true,
        horizontalTitleGap: 4,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(_iconSize / 2),
          child: TokenIcon(token: cryptoAmount.token, size: _iconSize),
        ),
        onTap: () => Navigator.pop(context, cryptoAmount.token),
        title: Text(
          cryptoAmount.token.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          fiatAmountText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
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

class _DefaultIcon extends StatelessWidget {
  const _DefaultIcon({this.size});

  @override
  Widget build(BuildContext context) => Image.asset(
        Assets.images.tokenLogo.path,
        width: size,
        height: size,
      );

  final double? size;
}
