import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dfunc/dfunc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/db/db.dart';
import '../../../gen/assets.gen.dart';
import '../data/token_dto.dart';
import '../data/token_repository.dart';

@lazySingleton
class TokenService {
  TokenService(this.tokenRepository);

  final TokenListRepository tokenRepository;

  Future<Either<Exception, void>> initializeDatabaseFromJson(
    Map<String, dynamic> json,
  ) =>
      tryEitherAsync(
        (_) async {
          await tokenRepository.clearAllTokens();
          for (final Map<String, dynamic> tokenData
              in json['tokens'] as Iterable<Map<String, dynamic>>) {
            final tokenRow = TokenRow.fromJson(tokenData);
            await tokenRepository.insertToken(tokenRow);
          }
        },
      );

  Future<Either<Exception, void>> initializeDatabaseFromCsvFile(
    String filePath,
  ) =>
      tryEitherAsync(
        (_) async {
          final file = File(filePath);
          await tokenRepository.clearAllTokens();

          final lines = file
              .openRead()
              .transform(utf8.decoder)
              .transform(const LineSplitter())
              .skip(1);

          await for (final line in lines) {
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
        },
      );

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
    if (extensionString == null || extensionString.isEmpty) return null;
    final parts = extensionString.split(':');
    if (parts.length == 2 && parts[0] == 'coingeckoId') {
      return Extensions(coingeckoId: parts[1]);
    }
    return null;
  }

  TokenDTO? findTokenByMint(String mint, List<TokenDTO> tokens) =>
      tokens.firstWhereOrNull((t) => t.address == mint);
}
