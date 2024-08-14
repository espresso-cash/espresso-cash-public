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
  const TokenUpdater(this.fileManager, this._ecClient);

  final FileManager fileManager;
  final EspressoCashClient _ecClient;

  @PostConstruct(preResolve: false)
  Future<void> call() =>
      TokensMetaStorage.getHash().letAsync((actualHash) async {
        final rootToken = ServicesBinding.rootIsolateToken;

        if (rootToken == null) return;

        final serverHash = await _ecClient.getTokensMeta();

        // ignore: avoid-weak-cryptographic-algorithms, non sensitive
        final shouldInitialize = serverHash.md5 != actualHash;

        if (shouldInitialize) {
          final file =
              await const FileManager().loadFromAppDir('tokens.csv.gz');

          await _ecClient.getTokensFile(file.path);

          await compute(
            _initializeFromAssets,
            IsolateParams(
              file,
              rootToken,
            ),
          );
        }
      });
}

Future<Either<Exception, void>> _initializeFromAssets(
  IsolateParams args,
) =>
    tryEitherAsync(
      (_) async {
        BackgroundIsolateBinaryMessenger.ensureInitialized(args.rootToken);

        final tokenStream = args.platformFile.openRead().decodeFile();

        final db = MyDatabase();

        await tokenStream.forEach((tokenRows) async {
          for (final tokenRow in tokenRows) {
            await db.transaction(
              () => db.into(db.tokenRows).insert(
                    tokenRow,
                    mode: InsertMode.insertOrReplace,
                  ),
            );
          }
        });

        // ignore: avoid-weak-cryptographic-algorithms, non sensitive
        final hash = await md5.bind(args.platformFile.openRead()).first;
        await TokensMetaStorage.saveHash(hash.toString());
      },
    );

class IsolateParams {
  const IsolateParams(this.platformFile, this.rootToken);

  final File platformFile;
  final RootIsolateToken rootToken;
}
