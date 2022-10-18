import 'package:dio/dio.dart';
import 'package:jupiter_aggregator/jupiter_aggregator.dart';
import 'package:retrofit/retrofit.dart';

part 'client.g.dart';

@RestApi(baseUrl: 'https://quote-api.jup.ag/v1')
abstract class JupiterAggregatorClient {
  factory JupiterAggregatorClient() => _JupiterAggregatorClient(Dio());

  /// Returns a hash map, input mint as key and an array of valid output mint
  /// as values, token mints are indexed to reduce the file size
  @GET('/indexed-route-map')
  Future<JupiterIndexedRouteMap> getIndexedRouteMap();

  /// Get quote for a given input mint, output mint and amount
  @GET('/quote')
  Future<QuoteResponseDto> getQuote(
    @Queries() QuoteRequestDto quoteRequestDto,
  );

  /// Get swap serialized transactions for a route
  @POST('/swap')
  Future<JupiterSwapTransactions> getSwapTransactions(
    @Queries() SwapRequestDto swapRequestDto,
  );
}
