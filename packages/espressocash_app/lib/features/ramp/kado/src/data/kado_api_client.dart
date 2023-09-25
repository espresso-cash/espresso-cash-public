import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

import '../../../../../config.dart';

part 'kado_api_client.freezed.dart';
part 'kado_api_client.g.dart';

@injectable
@RestApi(baseUrl: kadoApiBaseUrl)
abstract class KadoApiClient {
  @factoryMethod
  factory KadoApiClient(Dio dio) = _KadoApiClient;

  @GET('/v2/public/orders/{order_id}')
  Future<OrderStatusResponseDto> getOrderStatus(
    @Path('order_id') String orderId,
  );
}

@Freezed(toJson: false)
class OrderDataDto with _$OrderDataDto {
  const factory OrderDataDto({
    required String humanStatusField,
    required String machineStatusField,
  }) = _OrderDataDto;

  factory OrderDataDto.fromJson(Map<String, dynamic> json) =>
      _$OrderDataDtoFromJson(json);
}

@Freezed(toJson: false)
class OrderStatusResponseDto with _$OrderStatusResponseDto {
  const factory OrderStatusResponseDto({
    OrderDataDto? data,
  }) = _OrderStatusResponseDto;

  factory OrderStatusResponseDto.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusResponseDtoFromJson(json);
}
