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

  AsyncResult<TokenDetails> getTokenDetails(Token crypto) async =>
      _coingeckoClient
          .getCoinDetails(
            crypto.extensions?.coingeckoId ?? crypto.name,
            const TokenDetailsRequestDto(),
          )
          .toEither()
          .mapAsync(
            (response) => TokenDetails(
              name: response.name ?? crypto.name,
              description: _removeHtmlTags(response.description?['en'] ?? ''),
              marketCapRank: response.marketCapRank,
            ),
          );
}

String _removeHtmlTags(String htmlText) {
  final RegExp exp = RegExp(
    r'<[^>]*>',
    multiLine: true,
    caseSensitive: true,
  );

  return htmlText.replaceAll(exp, '');
}
