import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dfunc/dfunc.dart';
import 'package:dio/dio.dart';

void main() {
  _fetchCoins().then(_matchTokens).then((tokens) async {
    await _deleteLastFile();
    await _writeToFile(tokens);
  });
}

final Dio _dio = Dio();

Future<_CoinMap> _fetchCoins() async {
  final responses = await Future.wait(
    [_coinsUrl, _stablecoinsUrl].map<Future<Response<dynamic>>>(_dio.get).map(
          (it) =>
              it.then((response) => (response.data as List).whereType<_Json>()),
        ),
  );

  final coins = responses.first;
  final stablecoins = responses.last;

  return coins
      .map(
        (coin) {
          final solAddress = (coin['platforms'] as Map)['solana'];
          if (solAddress is! String) return null;

          final coingeckoId = coin['id'] as String?;

          final isStablecoin = stablecoins.any((st) => st['id'] == coingeckoId);

          return MapEntry(
            solAddress,
            _CoinData(coingeckoId: coingeckoId, isStablecoin: isStablecoin),
          );
        },
      )
      .whereNotNull()
      .let(Map.fromEntries);
}

Future<List<Map<String, String>>> _fetchTokenList() async {
  final response = await _dio.get<List<dynamic>>(_tokenListUrl);
  if (response.statusCode == 200) {
    return (response.data!)
        .map((e) => e as Map<String, dynamic>)
        .map((e) => e.map((k, v) => MapEntry(k, v.toString())))
        .toList();
  }
  throw Exception('Failed to load tokens');
}

Future<List<Map<String, String>>> _matchTokens(_CoinMap coins) async {
  final tokenList = await _fetchTokenList();

  return tokenList.map((token) => token.updateToken(coins)).toList();
}

Future<void> _writeToFile(List<Map<String, String>> tokens) async {
  final file = File(tokenFilePath);
  final directory = file.parent;

  if (!directory.existsSync()) {
    await directory.create(recursive: true);
  }

  final nonMainnetTokens = await file
      .let((f) => f.existsSync() ? f : null)
      ?.readAsString()
      .then((content) => content.split('\n'))
      .then(
        (lines) => lines
            .skip(1)
            .where((line) => line.isNotEmpty)
            .map((line) {
              final values = line.split(',');
              return {
                'address': values[0],
                'chainId': values[1],
                'symbol': values[2],
                'name': values[3],
                'decimals': values[4],
                'logoURI': values[5],
                'tags': values[6],
                'extensions': values[7],
              };
            })
            .toList()
            .where((t) => t['chainId'] != _mainnetChainId.toString())
            .toList(),
      );

  final allTokens = [
    ...tokens,
    if (nonMainnetTokens != null) ...nonMainnetTokens,
  ];

  final csv = StringBuffer()
    ..writeln('address,chainId,symbol,name,decimals,logoURI,tags,extensions')
    ..writeln(
      'So11111111111111111111111111111111111111111,101,SOL,Solana,9,https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/So11111111111111111111111111111111111111112/logo.png,[old-registry],coingeckoId:wrapped-solana',
    );

  for (final token in allTokens) {
    csv.writeln(
      [
        token['address'],
        token['chainId'],
        token['symbol'],
        token['name'],
        token['decimals'],
        token['logoURI'],
        token['tags'],
        token['extensions'],
      ].join(','),
    );
  }

  final List<int> csvBytes = utf8.encode(csv.toString());
  final List<int> compressedBytes = gzip.encode(csvBytes);

  await file.writeAsBytes(compressedBytes);
}

Future<void> _deleteLastFile() async {
  final directory = Directory('public');
  if (directory.existsSync()) {
    final files = directory
        .listSync()
        .whereType<File>()
        .where((file) => file.path == tokenFilePath)
        .toList();
    if (files.isNotEmpty) {
      files.sort((a, b) => b.path.compareTo(a.path));
      final lastFile = files.first;
      await lastFile.delete();
    }
  }
}

extension on Map<String, String> {
  Map<String, String> updateToken(_CoinMap coins) {
    final coin = coins[this['address']];

    if (coin != null) {
      if (coin.coingeckoId != null) {
        this['extensions'] = 'coingeckoId:${coin.coingeckoId}';
      }
      if (coin.isStablecoin) this['tags'] = 'stablecoin';
      this['chainId'] = _mainnetChainId.toString();
    }

    return this;
  }
}

typedef _CoinMap = Map<String, _CoinData>;
typedef _Json = Map<String, dynamic>;

class _CoinData {
  const _CoinData({this.coingeckoId, required this.isStablecoin});

  final String? coingeckoId;
  final bool isStablecoin;
}

const tokenFilePath = 'assets/tokens/tokens.csv.gz';

const _mainnetChainId = 101;

const _stablecoinsUrl =
    'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&category=stablecoins';
const _tokenListUrl = 'https://token.jup.ag/strict';
const _coinsUrl =
    'https://api.coingecko.com/api/v3/coins/list?include_platform=true';
