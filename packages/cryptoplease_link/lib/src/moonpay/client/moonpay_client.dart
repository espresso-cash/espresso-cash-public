import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'moonpay_client.freezed.dart';
part 'moonpay_client.g.dart';
part 'moonpay_quote_dto.dart';

@RestApi(baseUrl: 'https://api.moonpay.com/v3')
abstract class MoonpayClient {
  factory MoonpayClient() => _MoonpayClient(Dio());
  @GET('/currencies/{currencyCode}/buy_quote')
  Future<MoonpayQuoteDto> buyQuote({
    @Query('apiKey') required String apiKey,
    @Path('currencyCode') required String currencyCode,
    @Query('baseCurrencyCode') required String baseCurrencyCode,
    @Query('baseCurrencyAmount') required String baseCurrencyAmount,
  });

  @GET('/currencies/{currencyCode}/limits')
  Future<MoonpayLimitDto> limits({
    @Query('apiKey') required String apiKey,
    @Path('currencyCode') required String currencyCode,
    @Query('baseCurrencyCode') required String baseCurrencyCode,
  });

  @GET('/currencies/{currencyCode}/ask_price')
  Future<Map<String, double>> askPrice({
    @Query('apiKey') required String apiKey,
    @Path('currencyCode') required String currencyCode,
  });
}
