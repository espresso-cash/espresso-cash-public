import 'package:collection/collection.dart';
import 'package:dfunc/dfunc.dart';
import 'package:drift/src/runtime/data_class.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../../../data/db/db.dart';
import '../data/token_dto.dart';
import '../data/token_repository.dart';

@lazySingleton
class TokenService {
  TokenService(this.tokenRepository);

  final TokenListRepository tokenRepository;

  Future<Either<Exception, void>> initializeDatabaseWithJson(
    Map<String, dynamic> json,
  ) =>
      tryEitherAsync(
        (_) async {
          await tokenRepository.clearAllTokens();
          for (final tokenData in json['tokens'] as Iterable) {
            final tokenDTO =
                TokenDTO.fromJson(tokenData as Map<String, dynamic>);
            await tokenRepository.insertToken(tokenDTO as Insertable<TokenRow>);
          }
        },
      );

  //Future<Either<Exception, void>> initializeDatabaseFromJsonFile() {}

  //Future<Either<Exception, void>> initializeDatabaseFromCsvFile() {}

  TokenDTO? findTokenByMint(String mint, List<TokenDTO> tokens) =>
      tokens.firstWhereOrNull((t) => t.address == mint);
}
