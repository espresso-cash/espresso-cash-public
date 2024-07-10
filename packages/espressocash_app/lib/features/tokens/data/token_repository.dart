import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:async/async.dart';
import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/db/db.dart';
import '../../../data/db/open_connection.dart';
import '../../../utils/async_cache.dart';
import '../../accounts/auth_scope.dart';
import '../token.dart';

@Singleton(scope: authScope)
class TokenListRepository implements Disposable {
  TokenListRepository({
    required MyDatabase db,
    required EspressoCashClient ecClient,
  })  : _ecClient = ecClient,
        _db = db {
    initialize().foldAsync(
      (err) => kDebugMode ? debugPrint(err.toString()) : null,
      (msg) => kDebugMode ? debugPrint(msg) : null,
    );
  }

  final EspressoCashClient _ecClient;
  final MyDatabase _db;
  final AsyncCache<GetTokenListMetaResponseDto> _cache =
      AsyncCache(const Duration(minutes: 60));

  Future<Either<Exception, String>> initialize() =>
      _cache.fetchEither(_ecClient.getTokenListMeta).foldAsync(
            (e) => throw Exception(e),
            (GetTokenListMetaResponseDto serverHash) =>
                TokenListHashStorage.getHash()
                    .letAsync(
                      (actualHash) => actualHash != null
                          // ignore: avoid-weak-cryptographic-algorithms, non sensitive
                          ? serverHash.md5 != actualHash
                          : true,
                    )
                    .letAsync(
                      (shouldInitialize) => shouldInitialize
                          ? initializeFromFile(
                              _ecClient.baseUrl ??
                                  (kDebugMode
                                      ? 'http://localhost:8080/api/v1'
                                      : 'https://api.espressocash.com/api/v1'),
                            ).foldAsync(Left.new, (_) async {
                              await TokenListHashStorage.saveHash(
                                // ignore: avoid-weak-cryptographic-algorithms, non sensitive
                                serverHash.md5,
                              );

                              return const Right('token db updated');
                            })
                          : Future<Either<Exception, String>>(
                              () => const Right('token db already up to date'),
                            ),
                    ),
          );

  Future<Token?> getToken(String address) {
    final query = _db.select(_db.tokenRows)
      ..where((token) => token.address.equals(address))
      ..limit(1);

    return query.getSingleOrNull().letAsync((token) => token?.toModel());
  }

  @override
  Future<void> onDispose() async {
    await TokenListHashStorage.clearTimestamp();
    await _db.delete(_db.tokenRows).go();
  }

  Future<Either<Exception, void>> initializeFromFile(
    String baseUrl,
  ) =>
      tryEitherAsync((_) async {
        await onDispose();
        final receivePort = ReceivePort();

        final Isolate tokenListIsolate = await Isolate.spawn(
          _initializeFromFileIsolate,
          receivePort.sendPort,
        );

        final sendPort = await receivePort.first as SendPort;
        final responsePort = ReceivePort();
        sendPort.send([
          responsePort.sendPort,
          ServicesBinding.rootIsolateToken,
          baseUrl,
        ]);

        await for (final message in responsePort) {
          if (message == null) {
            tokenListIsolate.kill(priority: Isolate.immediate);
            receivePort.close();
            break;
          }
        }
      });

  static Future<void> _initializeFromFileIsolate(SendPort mainSendPort) async {
    final receivePort = ReceivePort();
    mainSendPort.send(receivePort.sendPort);

    await for (final message in receivePort) {
      if (message is List && message.length == 3) {
        final SendPort sendPort = message[0] as SendPort;
        final RootIsolateToken rootIsolateToken =
            message[1] as RootIsolateToken;
        final String baseUrl = message[2] as String;

        BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

        final database = MyDatabase.connect(
          DatabaseConnection(
            openConnection(),
          ),
        );

        final request = await HttpClient().getUrl(
          Uri.parse('$baseUrl/tokens/file'),
        );

        final response = await request.close();

        bool isFirstLine = true;

        final transformer =
            StreamTransformer<List<int>, List<TokenRow>>.fromHandlers(
          handleData: (data, sink) {
            final List<TokenRow> rows = [];
            final lines = utf8.decode(gzip.decode(data)).split('\n');
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
                    tags: _parseTags(values[6]),
                    extensions: _parseExtensions(values[7]),
                  ),
                );
              }
            }
            sink.add(rows);
          },
        );

        await response.transform(transformer).forEach((rows) async {
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

class TokenListHashStorage {
  static const String _key = 'lastTokenListTimestamp';

  static Future<void> saveHash(String timestamp) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, timestamp);
  }

  static Future<String?> getHash() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(_key);
  }

  static Future<void> clearTimestamp() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
