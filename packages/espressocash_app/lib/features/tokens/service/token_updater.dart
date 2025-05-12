import 'dart:core';

import 'package:dfunc/dfunc.dart';
import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import '../../../data/file_manager.dart';
import '../../accounts/auth_scope.dart';
import '../data/token_repository.dart';

@Singleton(scope: authScope)
class TokenUpdater {
  const TokenUpdater(
    this.fileManager,
    this._ecClient,
    this._tokenRepository,
    this._tokensMetaStorage,
  );

  final FileManager fileManager;
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
