import 'dart:core';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import '../../../data/db/db.dart';
import '../../../data/file_manager.dart';
import '../../accounts/auth_scope.dart';
import '../data/token_repository.dart';
import 'extensions.dart';

@Singleton(scope: authScope)
class TokenUpdater {
  TokenUpdater(this._db, this.fileManager, this._ecClient) {
    call();
  }

  final MyDatabase _db;
  final FileManager fileManager;
  final EspressoCashClient _ecClient;

  Future<void> call() =>
      TokensMetaStorage.getHash().letAsync((actualHash) async {
        if (actualHash == null) {
          final rootToken = ServicesBinding.rootIsolateToken;

          if (rootToken == null) return;

          final serverHash = await _ecClient.getTokensMeta();
          final actualHash = await TokensMetaStorage.getHash();

          final shouldInitialize =
              actualHash == null || serverHash.md5 != actualHash;

          if (shouldInitialize) {
            final file =
                await const FileManager().loadFromAppDir('tokens.csv.gz');

            await _ecClient.getTokensFile(file.path);
            await compute(
              initializeFromAssets,
              IsolateParams(file, ServicesBinding.rootIsolateToken!),
            );
          }
        }
      });

  Future<Either<Exception, void>> initializeFromAssets(
    IsolateParams args,
  ) =>
      tryEitherAsync(
        (_) async {
          BackgroundIsolateBinaryMessenger.ensureInitialized(args.rootToken);

          await args.platformFile.openRead().let(
                (stream) => stream
                    .decodeFile()
                    .forEach((tokenRows) {
                      for (final tokenRow in tokenRows) {
                        _db.transaction(
                          () => _db.into(_db.tokenRows).insert(
                                tokenRow,
                                mode: InsertMode.insertOrReplace,
                              ),
                        );
                      }
                    })
                    .letAsync((_) => md5.bind(stream).toString())
                    .letAsync(TokensMetaStorage.saveHash),
              );
        },
      );
}

class IsolateParams {
  IsolateParams(this.platformFile, this.rootToken);

  final File platformFile;
  final RootIsolateToken rootToken;
}
