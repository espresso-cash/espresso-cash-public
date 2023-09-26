import 'package:dio/dio.dart';
import 'package:dln_api/src/models/dto.dart';
import 'package:retrofit/retrofit.dart';

part 'client.g.dart';

/// For docs head to https://api.dln.trade/v1.0/#/DLN
@RestApi(baseUrl: 'https://api.dln.trade/v1.0/dln/order')
abstract class DlnApiClient {
  factory DlnApiClient() => _DlnApiClient(Dio());

  /// This endpoint returns the recommended take amount for creating DLN order.
  @GET('/quote')
  Future<QuoteResponseDto> getQuote(
    @Queries() QuoteRequestDto quoteRequestDto,
  );

  /// This endpoint returns the data for a transaction to place a cross-chain DLN order.
  @GET('/create-tx')
  Future<CreateTxResponseDto> createTx(
    @Queries() CreateTxRequestDto createTxRequestDto,
  );

  /// This endpoint returns the data of order.
  @GET('/{id}')
  Future<OrderResponseDto> getOrder(@Path() String id);

  /// This endpoint returns the status of order.
  @GET('/{id}/status')
  Future<OrderStatusResponseDto> getStatus(@Path() String id);
}
