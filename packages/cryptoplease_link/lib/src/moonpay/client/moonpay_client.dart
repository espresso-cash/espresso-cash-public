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
  Future<MoonpayQuoteDto> buyQuote(
    @Path('currencyCode') String currencyCode,
    @Queries() Map<String, dynamic> queries,
  );
}
