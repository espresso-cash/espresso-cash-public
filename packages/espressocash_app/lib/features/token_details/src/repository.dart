import 'package:dfunc/dfunc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/tokens/token.dart';
import 'data/coingecko_client.dart';
import 'token_details.dart';

@injectable
class TokenDetailsRepository {
  TokenDetailsRepository({
    required DetailsCoingeckoClient coingeckoClient,
  }) : _coingeckoClient = coingeckoClient;

  final DetailsCoingeckoClient _coingeckoClient;

  AsyncResult<TokenDetails> getTokenDetails({
    required Token token,
    required String fiatCurrency,
  }) async =>
      _coingeckoClient
          .getCoinDetails(
            token.extensions?.coingeckoId ?? token.name,
            const TokenDetailsRequestDto(marketData: true, localization: true),
          )
          .toEither()
          .mapAsync((response) {
        final marketData = response.marketData?.currentPrice;

        return TokenDetails(
          name: response.name ?? token.name,
          descriptions: response.description?.map(
            (k, v) => MapEntry(k, _removeHtmlTags(v)),
            ifRemove: (k, v) => v.isEmpty,
          ),
          marketCapRank: response.marketCapRank,
          marketPrice: marketData?[fiatCurrency],
        );
      });
}

String _removeHtmlTags(String htmlText) {
  final RegExp exp = RegExp(
    r'<[^>]*>',
    multiLine: true,
    caseSensitive: true,
  );

  return htmlText.replaceAll(exp, '');
}
