/// This script will create our local tokenlist.json that we will ship with the
/// apps
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
              .letAsync((response) => response.body.let(jsonDecode))
              .letAsync((data) => (data as List).whereType<_Json>()),
        ),
  );

  final coins = responses.first;
  final stablecoins = responses.last;

  return coins
      .map(
        (coin) {
          final solAddress = (coin['platforms'] as Map)['solana'];
          if (solAddress is! String) return null;

          final coingeckoId = coin['id'];
          if (coingeckoId is! String) return null;

          final isStablecoin = stablecoins.any((st) => st['id'] == coingeckoId);

          return MapEntry(
            solAddress,
            _CoinData(coingeckoId, isStablecoin: isStablecoin),
          );
        },
      )
      .whereNotNull()
      .let(Map.fromEntries);
}

Future<_Json> _matchTokens(_CoinMap coins) async {
  final response = await http.get(Uri.parse(_tokenListUrl));
  final coingecko = json.decode(response.body) as _Json;

  return coingecko
    ..update(
      'tokens',
      (tokens) => (tokens as List)
          .whereType<_Json>()
          .map((token) => token.updateToken(coins))
          .toList(),
    );
}

FutureOr<void> _writeToFile(_Json coingecko) async {
  final file = File(_path);

  // Let's keep the old non-mainnet tokens, since coingecko only return mainnet
  // tokens
  final nonMainnetTokens = await file
      .let((f) => f.existsSync() ? f : null)
      ?.readAsString()
      .letAsync(jsonDecode)
      .letAsync((it) => (it as Map)['tokens'])
      .letAsync((it) => (it as List).whereType<_Json>())
      .letAsync((it) => it.where((t) => t['chainId'] != _mainnetChainId));

  final allTokens = coingecko
    ..update(
      'tokens',
      (tokens) => (tokens as List)..addAll(nonMainnetTokens ?? <_Json>[]),
    );

  await file.writeAsString(jsonEncode(allTokens));
}

extension on _Json {
  _Json updateToken(_CoinMap coins) {
    final address = this['address'] as String;
    final coinData = coins[address];

    final coingeckoId = coinData?.coingeckoId;
    final isStablecoin = coinData?.isStablecoin ?? false;

    if (coingeckoId != null) this['extensions'] = {'coingeckoId': coingeckoId};
    if (isStablecoin) this['tags'] = const ['stablecoin'];

    return this
      ..update('chainId', (_) => _mainnetChainId)
      ..update('logoURI', (it) => it is String ? it.updateLogoUri() : '');
  }
}

extension on String {
  String updateLogoUri() {
    final uri = Uri.parse(this);
    final path = uri.path.replaceFirst('thumb', 'large');

    uri.replace(path: path);

    return uri.toString();
  }
}

typedef _CoinMap = Map<String, _CoinData>;
typedef _Json = Map<String, dynamic>;

class _CoinData {
  const _CoinData(this.coingeckoId, {required this.isStablecoin});

  final String coingeckoId;
  final bool isStablecoin;
}

const _path = 'lib/core/tokens/solana.tokenlist.json';

const _mainnetChainId = 101;

const _stablecoinsUrl =
    'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&category=stablecoins';
const _tokenListUrl = 'https://tokens.coingecko.com/solana/all.json';
const _coinsUrl =
    'https://api.coingecko.com/api/v3/coins/list?include_platform=true';
