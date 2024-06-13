import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart' show visibleForTesting;

import '../../config.dart';
import '../../data/db/db.dart';
import '../../di.dart';
import '../../gen/assets.gen.dart';
import 'data/token_repository.dart';
import 'services/token_service.dart';
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
    TokenService? service,
    @visibleForTesting Map<String, dynamic>? data,
  }) {
    if (_instance?.chainId == chainId) {
      // ignore: avoid-non-null-assertion, cannot be null here
      return _instance!;
    }
    _instance = TokenList._(
      chainId: chainId,
      data: data ?? _solanaTokenList,
      service: service ?? TokenService(_repository),
    );

    // ignore: avoid-non-null-assertion, cannot be null here
    return _instance!;
  }

  TokenList._({
    required this.chainId,
    required Map<String, dynamic> data,
    required this.service,
  })  : _parsedContent = ParsedContent.fromJson(data),
        _allTokensDB = [] {
    initialize();
  }
  static TokenList? _instance;

  static final TokenListRepository _repository =
      TokenListRepository(sl<MyDatabase>());

  final TokenService? service;

  final ParsedContent _parsedContent;
  final int chainId;

  // ignore: unused_field
  Iterable<TokenRow> _allTokensDB;

  Iterable<Token> get _allTokens => _parsedContent.tokens;

  Iterable<Token> get tokens => _allTokens.where((t) => t.chainId == chainId);

  Iterable<TokenRow> get tokensDB =>
      _allTokensDB.where((t) => t.chainId == chainId);

  Token? findTokenByMint(String mint) => mint == Token.sol.address
      ? Token.sol
      : tokens.firstWhereOrNull((t) => t.address == mint);

  // ignore: avoid-non-null-assertion, required here
  Token requireTokenByMint(String mint) => findTokenByMint(mint)!;

  Future<void> _populateDatabaseFromCSV() async {
    await service?.initializeDatabaseFromCsvFile(
      Assets.tokens.solanaTokenlist,
    );
    _allTokensDB = await service!.tokenRepository.getAllTokens();
  }

  Future<void> initialize() async {
    final tokenList = await service!.tokenRepository.getAllTokens();
    if (tokenList.isEmpty) {
      await _populateDatabaseFromCSV();
    } else {
      _allTokensDB = tokenList;
    }
  }
}

extension TokenExt on Iterable<Token> {
  Iterable<String> get symbols => map((t) => t.symbol);
}
