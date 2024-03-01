import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:jupiter_aggregator/jupiter_aggregator.dart';
import 'package:retrofit/retrofit.dart';

part 'client.g.dart';

/// For docs head to https://station.jup.ag/api-v6
@RestApi(
  baseUrl: String.fromEnvironment(
    'QUOTE_API_BASE',
    defaultValue: 'https://quote-api.jup.ag/v6',
  ),
)
abstract class JupiterAggregatorClient {
  factory JupiterAggregatorClient() => _JupiterAggregatorClient(Dio());

  /// Returns a hash map, input mint as key and an array of valid output mint
  /// as values, token mints are indexed to reduce the file size
  @GET('/indexed-route-map')
  Future<JupiterIndexedRouteMap> getIndexedRouteMap(
    @Queries() IndexedRouteMapRequestDto routeMapRequestDto,
  );

  /// Get quote for a given input mint, output mint and amount
  @GET('/quote')
  Future<QuoteResponseDto> getQuote(
    @Queries() QuoteRequestDto quoteRequestDto,
  );

  /// Get swap serialized transactions for a route
  @POST('/swap')
  Future<JupiterSwapResponseDto> getSwapTransactions(
    @Body() JupiterSwapRequestDto swapRequestDto,
  );
}

/// For docs head to https://docs.jup.ag/jupiter-api/price-api-for-solana
@RestApi(baseUrl: 'https://price.jup.ag/v4')
abstract class JupiterPriceClient {
  factory JupiterPriceClient() => _JupiterPriceClient(
        Dio()
          ..interceptors.add(
            InterceptorsWrapper(
              onResponse: (response, handler) {
                final content = response.data;
                if (content is String) response.data = json.decode(content);
                handler.next(response);
              },
            ),
          ),
      );

  /// Get the current USDC price for a given coin id
  @GET('/price')
  Future<PriceResponseDto> getPrice(
    @Queries() PriceRequestDto priceRequestDto,
  );
}
