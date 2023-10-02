import 'package:collection/collection.dart';
import 'package:dfunc/dfunc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart' show visibleForTesting;

import '../../config.dart';
import 'token.dart';

part 'token_list.g.dart';

// ignore: invalid_annotation_target, we need const here
@JsonLiteral('solana.tokenlist.json', asConst: true)
const Map<String, dynamic> _solanaTokenList = _$_solanaTokenListJsonLiteral;

// ignore: invalid_annotation_target, we need const here
@JsonLiteral('local.tokenlist.json', asConst: true)
@visibleForTesting
const Map<String, dynamic> localTokenList = _$localTokenListJsonLiteral;

class TokenList {
  factory TokenList({
    int chainId = currentChainId,
    @visibleForTesting Map<String, dynamic>? data,
  }) {
    if (_instance?.chainId == chainId) {
      // ignore: avoid-non-null-assertion, cannot be null here
      return _instance!;
    }
    _instance = TokenList._(chainId: chainId, data: data ?? _solanaTokenList);

    // ignore: avoid-non-null-assertion, cannot be null here
    return _instance!;
  }

  TokenList._({
    required this.chainId,
    required Map<String, dynamic> data,
  }) : _parsedContent = ParsedContent.fromJson(data);

  static TokenList? _instance;

  final ParsedContent _parsedContent;
  final int chainId;

  Iterable<Token> get _allTokens => _parsedContent.tokens;

  Iterable<Token> get tokens => _allTokens.where((t) => t.chainId == chainId);

  Token? findTokenByMint(String mint) => mint == Token.sol.address
      ? Token.sol
      : tokens.firstWhereOrNull((t) => t.address == mint);

  // ignore: avoid-non-null-assertion, required here
  Token requireTokenByMint(String mint) => findTokenByMint(mint)!;

  Token fromCoingecko({
    required String? coingeckoId,
    required String? symbol,
    required String? name,
    required String? image,
  }) =>
      tokens
          .singleWhereOrNull(
            (t) =>
                t.symbol.toLowerCase() == symbol &&
                t.coingeckoId == coingeckoId,
          )
          .ifNull(
            () => _createStubToken(
              coingeckoId: coingeckoId,
              symbol: symbol,
              name: name,
              image: image,
            ),
          );
}

extension TokenExt on Iterable<Token> {
  Iterable<String> get coingeckoIds =>
      this.map((t) => t.coingeckoId).whereType<String>();
}

Token _createStubToken({
  required String? coingeckoId,
  required String? symbol,
  required String? name,
  required String? image,
}) =>
    Token(
      chainId: currentChainId,
      address: coingeckoId ?? '',
      symbol: symbol?.toUpperCase() ?? '',
      name: name ?? '',
      decimals: 0,
      logoURI: image,
      tags: const [],
      extensions: Extensions(coingeckoId: coingeckoId),
    );
