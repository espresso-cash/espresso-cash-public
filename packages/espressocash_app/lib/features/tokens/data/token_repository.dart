import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solana/encoder.dart';

import '../../../data/db/db.dart';
import '../../../data/db/open_connection.dart';
import '../../../di.dart';
import '../../accounts/auth_scope.dart';
import '../../accounts/models/ec_wallet.dart';
import '../token.dart';

@Singleton(scope: authScope)
class TokenRepository implements Disposable {
  TokenRepository({
    required MyDatabase db,
    required EspressoCashClient ecClient,
  })  : _ecClient = ecClient,
        _db = db {
    _initialize();
  }

  final EspressoCashClient _ecClient;
  final MyDatabase _db;

  Future<void> _initialize() => _ecClient.getTokensMeta().letAsync(
        (GetTokensMetaResponseDto serverHash) => TokensMetaStorage.getHash()
            .letAsync(
          (actualHash) => actualHash != null
              // ignore: avoid-weak-cryptographic-algorithms, non sensitive
              ? serverHash.md5 != actualHash
              : true,
        )
            .letAsync((shouldInitialize) {
          if (shouldInitialize) {
            return _initializeFromFile().letAsync((_) async {
              await TokensMetaStorage.saveHash(
                // ignore: avoid-weak-cryptographic-algorithms, non sensitive
                serverHash.md5,
              );
            });
          }
        }),
      );

  Future<Token?> getToken(String address) {
    final query = _db.select(_db.tokenRows)
      ..where((token) => token.address.equals(address))
      ..limit(1);

    return query.getSingleOrNull().letAsync((token) => token?.toModel());
  }

  @override
  Future<void> onDispose() async {
    await TokensMetaStorage.clearHash();
    await _db.delete(_db.tokenRows).go();
  }

  Future<Either<Exception, void>> _initializeFromFile() =>
      tryEitherAsync((_) async {
        await onDispose();
        final receivePort = ReceivePort();

        final Isolate tokenListIsolate = await Isolate.spawn(
          _initializeIsolate,
          receivePort.sendPort,
        );
        final wallet = sl<ECWallet>();

        final sendPort = await receivePort.first as SendPort;
        final responsePort = ReceivePort();
        sendPort.send([
          responsePort.sendPort,
          ServicesBinding.rootIsolateToken,
          wallet,
        ]);

        await for (final message in responsePort) {
          if (message == null) {
            tokenListIsolate.kill(priority: Isolate.immediate);
            receivePort.close();
            break;
          }
        }
      });

  static Future<void> _initializeIsolate(SendPort mainSendPort) async {
    final receivePort = ReceivePort();
    mainSendPort.send(receivePort.sendPort);

    await for (final message in receivePort) {
      if (message is List && message.length == 3) {
        final SendPort sendPort = message[0] as SendPort;
        final RootIsolateToken rootIsolateToken =
            message[1] as RootIsolateToken;
        final ECWallet wallet = message[2] as ECWallet;

        BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

        final database = MyDatabase.connect(
          DatabaseConnection(
            openConnection(),
          ),
        );

        final appDir = await getTemporaryDirectory();

        final path = '${appDir.path}${Platform.pathSeparator}tokens.csv.gz';

        await EspressoCashClient(
          baseUrl: kDebugMode ? 'http://localhost:8080/api/v1' : null,
          sign: (data) async => (
            signature:
                await wallet.sign([Uint8List.fromList(utf8.encode(data))]).then(
              (value) => value.first.toBase58(),
            ),
            publicKey: wallet.publicKey.toBase58(),
          ),
        ).getTokensFile(path);

        final File myFile = File(path);

        await myFile.openRead().transformToTokenRows().forEach((rows) async {
          await database.transaction(() async {
            await database.batch(
              (batch) => batch.insertAll(
                database.tokenRows,
                rows,
                mode: InsertMode.insertOrReplace,
              ),
            );
          });

          sendPort.send(null);
          receivePort.close();
        });
      }
    }
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

extension _StreamExtension on Stream<List<int>> {
  Stream<List<TokenRow>> transformToTokenRows() => transform(
        StreamTransformer<List<int>, List<TokenRow>>.fromHandlers(
          handleData: (data, sink) {
            final List<TokenRow> rows = [];
            final lines = utf8.decode(gzip.decode(data)).split('\n');
            bool isFirstLine = true;
            for (final line in lines) {
              if (isFirstLine) {
                isFirstLine = false;
                continue;
              }
              final values = line.split(',');
              if (values.length >= 8) {
                rows.add(
                  TokenRow(
                    address: values[0],
                    chainId: int.parse(values[1]),
                    symbol: values[2],
                    name: values[3],
                    decimals: int.parse(values[4]),
                    logoURI: values[5],
                    tags: values[6]._parseTags(),
                    extensions: values[7]._parseExtensions(),
                  ),
                );
              }
            }
            sink.add(rows);
          },
        ),
      );
}

extension _TagStringParser on String {
  List<String>? _parseTags() {
    if (this.isEmpty) return null;

    return replaceAll('[', '')
        .replaceAll(']', '')
        .split(',')
        .map((e) => e.trim())
        .toList();
  }
}

extension _ExtensionStringParser on String {
  Extensions? _parseExtensions() {
    final parts = split(':');

    return (parts.length == 2 && parts[0] == 'coingeckoId')
        ? Extensions(coingeckoId: parts[1])
        : null;
  }
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

  static Future<void> clearHash() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
