import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart' show visibleForTesting;
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  final TokenService service;

  final ParsedContent _parsedContent;
  final int chainId;

  Iterable<TokenRow> _allTokensDB;

  Iterable<Token> get _allTokens => _parsedContent.tokens;

  Iterable<Token> get tokens => _allTokens.where((t) => t.chainId == chainId);

  Iterable<TokenRow> get tokensDB =>
      _allTokensDB.where((t) => t.chainId == chainId);

  Token? findTokenByMint(String mint) => mint == Token.sol.address
      ? Token.sol
      : tokens.firstWhereOrNull((t) => t.address == mint);

  // ignore: avoid-non-null-assertion, cannot be null here
  Token requireTokenByMint(String mint) => findTokenByMint(mint)!;

  Future<void> initialize() async {
    final csvFilePath = Assets.tokens.solanaTokenlist;

    final newTimestamp =
        TimestampStorage.extractTimestamp(basename(csvFilePath));

    final lastTimestamp = await TimestampStorage.getTimestamp();

    if (newTimestamp != null && newTimestamp != lastTimestamp) {
      await service.initializeDatabaseFromCsvFile(csvFilePath);
      await TimestampStorage.saveTimestamp(newTimestamp);
    }
  }
}

extension TokenExt on Iterable<Token> {
  Iterable<String> get symbols => map((t) => t.symbol);
}

class TimestampStorage {
  static const String _key = 'lastTokenListTimestamp';

  static Future<void> saveTimestamp(String timestamp) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, timestamp);
  }

  static Future<String?> getTimestamp() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key);
  }

  static String? extractTimestamp(String filePath) {
    final regex = RegExp(r'solana\.tokenlist\.(.+)');
    final match = regex.firstMatch(filePath);
    return match?.group(1);
  }
}
