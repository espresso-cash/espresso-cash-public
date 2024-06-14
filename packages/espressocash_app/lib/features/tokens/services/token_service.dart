import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import '../../../data/db/db.dart';
import '../data/token_repository.dart';
import '../token.dart';

@lazySingleton
class TokenService {
  const TokenService(this.tokenRepository);

  final TokenListRepository tokenRepository;

  Future<Either<Exception, void>> initializeDatabaseFromCsvFile(
    String filePath,
  ) =>
      tryEitherAsync((_) async {
        final String data = await rootBundle.loadString(filePath);
        await compute(_parseAndInsertTokens, data);
      });

  Future<void> _parseAndInsertTokens(String data) async {
    final lines = const LineSplitter().convert(data).skip(1);

    await tokenRepository.clearAllTokens();

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

      await tokenRepository.insertToken(tokenRow);
    }
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
