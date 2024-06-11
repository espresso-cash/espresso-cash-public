import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:collection/collection.dart';
import 'package:dfunc/dfunc.dart';
import 'package:http/http.dart' as http;

void main() {
  _fetchCoins().then(_matchTokens).then(_writeToFile);
}

Future<_CoinMap> _fetchCoins() async {
  final responses = await Future.wait(
    [_coinsUrl, _stablecoinsUrl].map(Uri.parse).map(http.get).map(
          (it) => it
              .then((response) => jsonDecode(response.body))
              .then((data) => (data as List).whereType<_Json>()),
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
  final response = await http.get(Uri.parse(_tokenListUrl));
  if (response.statusCode == 200) {
    return (json.decode(response.body) as List)
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
  final file = File(_path);
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

  final csv = StringBuffer();

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

  await file.writeAsString(csv.toString());
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

const _path = 'lib/features/tokens/solana.tokenlist.csv';

const _mainnetChainId = 101;

const _stablecoinsUrl =
    'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&category=stablecoins';
const _tokenListUrl = 'https://token.jup.ag/strict';
const _coinsUrl =
    'https://api.coingecko.com/api/v3/coins/list?include_platform=true';
