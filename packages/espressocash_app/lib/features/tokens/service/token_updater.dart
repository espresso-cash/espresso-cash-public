import 'dart:core';

import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import '../../accounts/auth_scope.dart';
import '../data/token_repository.dart';

@Singleton(scope: authScope)
class TokenUpdater {
  const TokenUpdater({
    required EspressoCashClient ecClient,
    required TokenRepository tokenRepository,
    required TokensMetaStorage tokensMetaStorage,
  }) : _ecClient = ecClient,
       _tokenRepository = tokenRepository,
       _tokensMetaStorage = tokensMetaStorage;

  final EspressoCashClient _ecClient;
  final TokenRepository _tokenRepository;
  final TokensMetaStorage _tokensMetaStorage;

  @PostConstruct(preResolve: false)
  Future<void> call() => tryEitherAsync((_) async {
    final actualHash = _tokensMetaStorage.getHash();
    final rootToken = ServicesBinding.rootIsolateToken;

    if (rootToken == null) return;

    final serverHash = await _ecClient.getTokensMeta();
    // ignore: avoid-weak-cryptographic-algorithms, non sensitive
    final shouldInitialize = serverHash.md5 != actualHash;

    if (shouldInitialize) {
      await _tokenRepository.update(_ecClient);
    }
  });
}
