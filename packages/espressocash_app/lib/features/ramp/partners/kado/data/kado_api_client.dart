// ignore_for_file: invalid_annotation_target

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

import '../../../../../../config.dart';

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
    String? depositAddress,
    @JsonKey(unknownEnumValue: MachineStatus.unknown)
    required MachineStatus machineStatusField,
    QuoteDto? quote,
    AmountDto? totalFee,
    required AmountDto payAmount,
    String? txHash,
  }) = _OrderDataDto;

  factory OrderDataDto.fromJson(Map<String, dynamic> json) =>
      _$OrderDataDtoFromJson(json);
}

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum MachineStatus {
  settled,
  cardPaymentFailed,
  achPaymentFailed,
  wireTransferPending,
  pendingPayment,
  delayedSettlement,
  unknown,
}

@Freezed(toJson: false)
class QuoteDto with _$QuoteDto {
  const factory QuoteDto({
    required num price,
  }) = _QuoteDto;

  factory QuoteDto.fromJson(Map<String, dynamic> json) =>
      _$QuoteDtoFromJson(json);
}

@Freezed(toJson: false)
class AmountDto with _$AmountDto {
  const factory AmountDto({
    required num amount,
  }) = _AmountDto;

  factory AmountDto.fromJson(Map<String, dynamic> json) =>
      _$AmountDtoFromJson(json);
}

@Freezed(toJson: false)
class OrderStatusResponseDto with _$OrderStatusResponseDto {
  const factory OrderStatusResponseDto({
    OrderDataDto? data,
  }) = _OrderStatusResponseDto;

  factory OrderStatusResponseDto.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusResponseDtoFromJson(json);
}
