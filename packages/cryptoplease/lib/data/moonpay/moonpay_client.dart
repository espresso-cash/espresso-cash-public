import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'moonpay_client.freezed.dart';
part 'moonpay_client.g.dart';
part 'moonpay_dto.dart';

@RestApi(baseUrl: 'https://api.moonpay.com/v3')
abstract class MoonpayClient {
  factory MoonpayClient() => _MoonpayClient(Dio());

  @GET('/currencies/{currencyCode}/buy_quote')
  Future<BuyQuoteResponseDto> buyQuote({
    @Query('apiKey') required String apiKey,
    @Path('currencyCode') required String currencyCode,
    @Query('baseCurrencyCode') required String baseCurrencyCode,
    @Query('baseCurrencyAmount') required String baseCurrencyAmount,
    @Query('areFeesIncluded') required bool areFeesIncluded,
  });

  @GET('/currencies/{currencyCode}/limits')
  Future<LimitResponseDto> limits({
    @Query('apiKey') required String apiKey,
    @Path('currencyCode') required String currencyCode,
    @Query('baseCurrencyCode') required String baseCurrencyCode,
    @Query('areFeesIncluded') required bool areFeesIncluded,
  });

  @GET('/currencies/{currencyCode}/ask_price')
  Future<AskPriceResponseDto> askPrice({
    @Query('apiKey') required String apiKey,
    @Path('currencyCode') required String currencyCode,
  });
}
