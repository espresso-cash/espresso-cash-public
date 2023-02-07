import 'package:dio/dio.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:retrofit/retrofit.dart';

part 'client.g.dart';

@RestApi(baseUrl: 'https://cryptoplease-link.web.app/api/v1')
abstract class CryptopleaseClient {
  factory CryptopleaseClient({String? baseUrl}) => _CryptopleaseClient(
        Dio(),
        baseUrl: baseUrl,
      );

  @POST('/addFunds')
  Future<AddFundsResponseDto> addFunds(@Body() AddFundsRequestDto request);

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

  @POST('/getFees')
  Future<GetFeesResponseDto> getFees();

  @POST('/getSwapRoute')
  Future<SwapRouteResponseDto> getSwapRoute(
    @Body() SwapRouteRequestDto request,
  );
}
