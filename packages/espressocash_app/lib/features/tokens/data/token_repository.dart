import 'dart:async';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/db/db.dart';
import '../../../data/file_manager.dart';
import '../service/extensions.dart';
import '../token.dart';

@Singleton()
class TokenRepository {
  TokenRepository(this._db, this.fileManager) {
    initialize();
  }

  final MyDatabase _db;
  final FileManager fileManager;

  Future<void> initialize() =>
      TokensMetaStorage.getHash().letAsync((actualHash) async {
        if (actualHash == null) return;

        final rootToken = ServicesBinding.rootIsolateToken;

        if (rootToken == null) return;

        final assetFile = await rootBundle.load('assets/tokens/tokens.csv.gz');

        final platformFile = await fileManager.loadFromAppDir('tokens.csv.gz');

        await compute(
          initializeFromAssets,
          IsolateParams(assetFile, platformFile, rootToken),
        );
      });

  Future<Either<Exception, void>> initializeFromAssets(
    IsolateParams args,
  ) =>
      tryEitherAsync(
        (_) async {
          BackgroundIsolateBinaryMessenger.ensureInitialized(args.rootToken);

          await args.platformFile
              .writeAsBytes(args.data.buffer.asUint8List())
              .letAsync(
                (file) => file.openRead().let(
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
                          // ignore: avoid-weak-cryptographic-algorithms, non sensitive
                          .letAsync((_) => md5.bind(stream).toString())
                          .letAsync(TokensMetaStorage.saveHash),
                    ),
              );
        },
      );

  Future<Token?> getToken(String address) {
    final query = _db.select(_db.tokenRows)
      ..where((token) => token.address.equals(address))
      ..limit(1);

    return query.getSingleOrNull().letAsync((token) => token?.toModel());
  }
}

class IsolateParams {
  const IsolateParams(this.data, this.platformFile, this.rootToken);

  final ByteData data;
  final File platformFile;
  final RootIsolateToken rootToken;
}

abstract final class TokensMetaStorage {
  static const String _key = 'tokensFileHash';

  static Future<void> saveHash(String timestamp) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, timestamp);
  }

  static Future<String?> getHash() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(_key);
  }
}
