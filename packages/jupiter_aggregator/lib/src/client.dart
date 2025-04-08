import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:jupiter_aggregator/jupiter_aggregator.dart';
import 'package:retrofit/retrofit.dart';

part 'client.g.dart';

const _defaultSwapApiUrl = 'https://quote-api.jup.ag/v6';
const _defaultPriceApiUrl = 'https://api.jup.ag/';

/// For docs head to https://station.jup.ag/api-v6
@RestApi()
abstract class JupiterAggregatorClient {
  factory JupiterAggregatorClient({String? baseUrl, String? apiKey}) => _JupiterAggregatorClient(
    Dio()
      ..interceptors.addAll([
        if (apiKey != null)
          InterceptorsWrapper(
            onRequest: (options, handler) {
              options.headers['x-api-key'] = apiKey;
              handler.next(options);
            },
          ),
      ]),
    baseUrl:
        baseUrl ?? const String.fromEnvironment('QUOTE_API_BASE', defaultValue: _defaultSwapApiUrl),
  );

  /// Get quote for a given input mint, output mint and amount
  @GET('/quote')
  Future<QuoteResponseDto> getQuote(@Queries() QuoteRequestDto quoteRequestDto);

  /// Get swap serialized transactions for a route
  @POST('/swap')
  Future<JupiterSwapResponseDto> getSwapTransactions(@Body() JupiterSwapRequestDto swapRequestDto);
}

/// For docs head to https://station.jup.ag/docs/apis/price-api-v2
@RestApi()
abstract class JupiterPriceClient {
  factory JupiterPriceClient({String? baseUrl, String? apiKey}) => _JupiterPriceClient(
    Dio()
      ..interceptors.addAll([
        InterceptorsWrapper(
          onResponse: (response, handler) {
            final content = response.data;
            if (content is String) response.data = json.decode(content);
            handler.next(response);
          },
        ),
        if (apiKey != null)
          InterceptorsWrapper(
            onRequest: (options, handler) {
              options.headers['x-api-key'] = apiKey;
              handler.next(options);
            },
          ),
      ]),
    baseUrl: baseUrl ?? _defaultPriceApiUrl,
  );

  /// Get the current USDC price for a given coin id
  @GET('/price/v2')
  Future<PriceResponseDto> getPrice(@Queries() PriceRequestDto priceRequestDto);
}
