import 'dart:async';
import 'dart:convert';

import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/db/db.dart';
import '../../../gen/assets.gen.dart';
import '../token.dart';

@singleton
class TokenListRepository {
  const TokenListRepository(this._db);

  final MyDatabase _db;

  Future<void> initialize() async {
    final csvFilePath = Assets.tokens.values.first;

    final actualTimestamp =
        TimestampStorage.extractTimestamp(basename(csvFilePath));

    final lastTimestamp = await TimestampStorage.getTimestamp();

    if (actualTimestamp != null && actualTimestamp != lastTimestamp) {
      await _initializeDatabaseFromCsvFile(csvFilePath);
      await TimestampStorage.saveTimestamp(actualTimestamp);
    }
  }

  Future<Token?> getToken(String address) {
    final query = _db.select(_db.tokenRows)
      ..where((token) => token.address.equals(address))
      ..limit(1);

    return query.getSingleOrNull().letAsync((token) => token?.toModel());
  }

  Future<dynamic> insertToken(TokenRow token) => _db.transaction(() async {
        await _db.into(_db.tokenRows).insert(
              token,
              mode: InsertMode.insertOrReplace,
            );
      });

  Future<dynamic> insertTokens(Iterable<TokenRow> tokens) =>
      _db.transaction(() async {
        await clearAllTokens();
        await _db.batch(
          (batch) => batch.insertAll(
            _db.tokenRows,
            tokens.map(
              (e) => TokenRow(
                chainId: e.chainId,
                address: e.address,
                symbol: e.symbol,
                name: e.name,
                decimals: e.decimals,
                logoURI: e.logoURI,
                tags: e.tags,
                extensions: e.extensions,
              ),
            ),
            mode: InsertMode.insertOrReplace,
          ),
        );
      });

  Future<dynamic> updateToken(Insertable<TokenRow> token) =>
      _db.update(_db.tokenRows).replace(token);

  Future<dynamic> deleteToken(Insertable<TokenRow> token) =>
      _db.delete(_db.tokenRows).delete(token);

  Future<dynamic> clearAllTokens() => _db.delete(_db.tokenRows).go();

  Future<Either<Exception, void>> _initializeDatabaseFromCsvFile(
    String filePath,
  ) =>
      tryEitherAsync((_) async {
        final String data = await rootBundle.loadString(filePath);
        final List<TokenRow> tokenIterable =
            await compute(_parseAndInsertTokens, data);
        await insertTokens(tokenIterable);
      });

  List<TokenRow> _parseAndInsertTokens(String data) {
    final lines = const LineSplitter().convert(data).skip(1);
    final List<TokenRow> tokenIterable = [];

    for (final line in lines) {
      final values = line.split(',');
      final tags = _parseTags(values[6]);
      final extensions = _parseExtensions(values[7]);

      final tokenRow = TokenRow(
        chainId: int.parse(values[1]),
        address: values[0],
        symbol: values[2],
        name: values[3],
        decimals: int.parse(values[4]),
        logoURI: values[5],
        tags: tags,
        extensions: extensions,
      );

      tokenIterable.add(tokenRow);
    }

    return tokenIterable;
  }

  List<String>? _parseTags(String? tagString) {
    if (tagString == null || tagString.isEmpty) return null;

    return tagString
        .replaceAll('[', '')
        .replaceAll(']', '')
        .split(',')
        .map((e) => e.trim())
        .toList();
  }

  Extensions? _parseExtensions(String? extensionString) {
    final parts = extensionString?.split(':');

    return (parts != null && parts.length == 2 && parts[0] == 'coingeckoId')
        ? Extensions(coingeckoId: parts[1])
        : null;
  }
}

extension TokenRowsExt on TokenRow {
  Token toModel() => Token(
        address: address,
        name: name,
        symbol: symbol,
        decimals: decimals,
        logoURI: logoURI,
        chainId: chainId,
        tags: tags,
        extensions: extensions,
      );
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
