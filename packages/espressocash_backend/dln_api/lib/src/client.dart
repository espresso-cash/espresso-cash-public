import 'package:dio/dio.dart';
import 'package:dln_api/src/models/dto.dart';
import 'package:retrofit/retrofit.dart';

part 'client.g.dart';

/// For docs head to https://api.dln.trade/v1.0/#/DLN
@RestApi(baseUrl: 'https://api.dln.trade/v1.0/dln')
abstract class DlnApiClient {
  factory DlnApiClient() => _DlnApiClient(Dio());

  /// This endpoint returns the recommended take amount for creating DLN order.
  @GET('/order/quote')
  Future<QuoteResponseDto> getQuote(
    @Queries() QuoteRequestDto quoteRequestDto,
  );

  /// This endpoint returns the data for a transaction to place a cross-chain DLN order.
  @GET('/order/create-tx')
  Future<CreateTxResponseDto> createTx(
    @Queries() CreateTxRequestDto createTxRequestDto,
  );

  /// This endpoint returns the data of order.
  @GET('/order/{id}')
  Future<OrderResponseDto> getOrder(@Path() String id);

  /// This endpoint returns the status of order.
  @GET('/order/{id}/status')
  Future<OrderStatusResponseDto> getStatus(@Path() String id);

  @GET('/tx/{hash}/order-ids')
  Future<OrderIdTxResponseDto> getOrderIdByHash(@Path() String hash);

  /// This endpoint generates a transaction that cancels the given order.
  @GET('/order/{id}/cancel-tx')
  Future<CancelTxResponseDto> cancelTx(@Path() String id);
}
