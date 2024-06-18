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

class TokenList {
  factory TokenList({
    int chainId = currentChainId,
    TokenService? service,
  }) {
    if (_instance?.chainId == chainId) {
      // ignore: avoid-non-null-assertion, cannot be null here
      return _instance!;
    }
    _instance = TokenList._(
      chainId: chainId,
      service: service ?? TokenService(_repository),
    );

    // ignore: avoid-non-null-assertion, cannot be null here
    return _instance!;
  }

  TokenList._({
    required this.chainId,
    required this.service,
  }) {
    initialize();
  }
  static TokenList? _instance;

  static final TokenListRepository _repository =
      TokenListRepository(sl<MyDatabase>());

  final TokenService service;

  final int chainId;

  Token getTokenByMint(String mint) => mint == Token.sol.address
      ? Token.sol
      : service.tokenRepository.getToken(mint);

  Future<void> initialize() async {
    final csvFilePath = Assets.tokens.values.first;

    final actualTimestamp =
        TimestampStorage.extractTimestamp(basename(csvFilePath));

    final lastTimestamp = await TimestampStorage.getTimestamp();

    if (actualTimestamp != null && actualTimestamp != lastTimestamp) {
      await service.initializeDatabaseFromCsvFile(csvFilePath);
      await TimestampStorage.saveTimestamp(actualTimestamp);
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
    final regex = RegExp(r'solana\.tokenlist\.(\d+)\.csv');
    final match = regex.firstMatch(filePath);

    return match?.group(1);
  }
}
