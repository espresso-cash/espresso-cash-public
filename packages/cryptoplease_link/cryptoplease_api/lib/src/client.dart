import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'client.g.dart';

@RestApi(baseUrl: 'https://cryptoplease-link.web.app/api/v1')
abstract class CryptopleaseClient {
  factory CryptopleaseClient() => _CryptopleaseClient(Dio());

  @POST('/addFunds')
  Future<AddFundsResponseDto> addFunds(@Body() AddFundsRequestDto request);

  @POST('/buyQuote')
  Future<QuoteResponseDto> buyQuote(@Body() QuoteRequestDto request);

  @POST('/limit')
  Future<LimitResponseDto> limit(@Body() LimitRequestDto request);

  @POST('/createPayment')
  Future<CreatePaymentResponseDto> createPayment(
    @Body() CreatePaymentRequestDto request,
  );

  @POST('/receivePayment')
  Future<ReceivePaymentResponseDto> receivePayment(
    @Body() ReceivePaymentRequestDto request,
  );

  @POST('/createDirectPayment')
  Future<CreateDirectPaymentResponseDto> createDirectPayment(
    @Body() CreateDirectPaymentRequestDto request,
  );
}
