import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/db/db.dart';
import '../../../gen/assets.gen.dart';
import '../token.dart';

@singleton
class TokenListRepository {
  TokenListRepository(this._db) {
    initialize();
  }

  final MyDatabase _db;

  Future<void> initialize() async {
    final String csvFilePath = Assets.tokens.values.first;

    final String? actualTimestamp =
        TimestampStorage.extractTimestamp(csvFilePath);

    final String? lastTimestamp = await TimestampStorage.getTimestamp();

    if (actualTimestamp != null && actualTimestamp != lastTimestamp) {
      await _initializeDatabaseFromCsvFile(csvFilePath);
      await TimestampStorage.saveTimestamp(actualTimestamp);
    }
  }

  Future<Token?> getToken(String address) {
    final query = _db.select(_db.tokenRows)
      ..where((token) => token.address.equals(address))
      ..limit(1);

    return query.getSingleOrNull().letAsync((token) => token?.toModel());
  }

  Future<dynamic> insertToken(TokenRow token) => _db.transaction(() async {
        await _db.into(_db.tokenRows).insert(
              token,
              mode: InsertMode.insertOrReplace,
            );
      });

  Future<dynamic> insertTokens(Iterable<TokenRow> tokens) =>
      _db.transaction(() async {
        await clearAllTokens();
        await _db.batch(
          (batch) => batch.insertAll(
            _db.tokenRows,
            tokens.map(
              (e) => TokenRow(
                chainId: e.chainId,
                address: e.address,
                symbol: e.symbol,
                name: e.name,
                decimals: e.decimals,
                logoURI: e.logoURI,
                tags: e.tags,
                extensions: e.extensions,
              ),
            ),
            mode: InsertMode.insertOrReplace,
          ),
        );
      });

  Future<dynamic> updateToken(Insertable<TokenRow> token) =>
      _db.update(_db.tokenRows).replace(token);

  Future<dynamic> deleteToken(Insertable<TokenRow> token) =>
      _db.delete(_db.tokenRows).delete(token);

  Future<dynamic> clearAllTokens() => _db.delete(_db.tokenRows).go();

  Future<Either<Exception, void>> _initializeDatabaseFromCsvFile(
    String filePath,
  ) =>
      tryEitherAsync((_) async {
        final ReceivePort receivePort = ReceivePort();

        await Isolate.spawn(_entry, receivePort.sendPort);

        final SendPort sendPort = await receivePort.first as SendPort;

        final ReceivePort responsePort = ReceivePort();

        sendPort.send([
          responsePort.sendPort,
          ServicesBinding.rootIsolateToken,
        ]);

        final Completer<void> completer = Completer<void>();
        StreamSubscription<Uint8List>? subscription;

        subscription = load(filePath).listen(
          sendPort.send,
          onDone: () {
            sendPort.send(null);
            completer.complete();
          },
          onError: (Object error, StackTrace stackTrace) {
            completer.completeError(error, stackTrace);
          },
        );

        await completer.future;
        await subscription.cancel();
      });

  Future<void> _entry(SendPort mainSendPort) async {
    final ReceivePort receivePort = ReceivePort();

    final List<TokenRow> tokenRows = [];
    final Completer<void> completer = Completer<void>();

    SendPort? sendPort;
    RootIsolateToken isolateToken;
    StreamSubscription<dynamic>? subscription;

    mainSendPort.send(receivePort.sendPort);

    subscription = receivePort.listen(
      (message) {
        if (message == null) {
          completer.complete();

          return;
        }
        if (message is Uint8List) {
          final Uint8List chunk = message;
          final String chunkString = utf8.decode(chunk);
          final List<TokenRow> rows = _parseChunk(chunkString);
          tokenRows.addAll(rows);
        }
        if (message is List && message is! Uint8List) {
          sendPort = message[0] as SendPort;
          isolateToken = message[1] as RootIsolateToken;

          BackgroundIsolateBinaryMessenger.ensureInitialized(isolateToken);
        }
      },
      onError: (Object error, StackTrace stackTrace) {
        completer.completeError(error, stackTrace);
      },
    );

    await completer.future;
    await insertTokens(tokenRows);
    await subscription.cancel();
    sendPort?.send(null);
  }

  List<TokenRow> _parseChunk(String chunk) {
    final List<TokenRow> tokenIterable = [];
    final List<String> lines = chunk.split('\n');
    for (int i = 1; i < lines.length; i++) {
      final line = lines[i];
      if (line.trim().isEmpty) continue;
      final values = line.split(',');
      if (values.length < 8) continue;
      final tags = _parseTags(values[6]);
      final extensions = _parseExtensions(values[7]);

      tokenIterable.add(
        TokenRow(
          address: values[0],
          chainId: int.parse(values[1]),
          symbol: values[2],
          name: values[3],
          decimals: int.parse(values[4]),
          logoURI: values[5],
          tags: tags,
          extensions: extensions,
        ),
      );
    }

    return tokenIterable;
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
    final List<String>? parts = extensionString?.split(':');

    return (parts != null && parts.length == 2 && parts[0] == 'coingeckoId')
        ? Extensions(coingeckoId: parts[1])
        : null;
  }
}

Stream<Uint8List> load(String key) {
  final StreamController<Uint8List> controller = StreamController<Uint8List>();

  final Uint8List encoded = utf8.encode(Uri(path: Uri.encodeFull(key)).path);

  ServicesBinding.instance.defaultBinaryMessenger
      .send(
    'flutter/assets',
    ByteData.sublistView(encoded),
  )
      ?.then((ByteData? asset) {
    if (asset == null) {
      controller
        ..addError(
          FlutterError.fromParts(<DiagnosticsNode>[
            ErrorDescription('The asset does not exist or has empty data.'),
          ]),
        )
        ..close();

      return;
    }

    final int length = asset.lengthInBytes;
    const int chunkSize = 1024;

    for (int offset = 0; offset < length; offset += chunkSize) {
      final int end =
          (offset + chunkSize < length) ? offset + chunkSize : length;
      controller.add(asset.buffer.asUint8List(offset, end - offset));
    }
    controller.close();
  }).catchError((Object error) {
    controller
      ..addError(error)
      ..close();
  });

  return controller.stream;
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

class TimestampStorage {
  static const String _key = 'lastTokenListTimestamp';

  static Future<void> saveTimestamp(String timestamp) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, timestamp);
  }

  static Future<String?> getTimestamp() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(_key);
  }

  static String? extractTimestamp(String filePath) {
    final regex = RegExp(r'solana\.tokenlist\.(\d+)\.csv');
    final match = regex.firstMatch(filePath);

    return match?.group(1);
  }
}
