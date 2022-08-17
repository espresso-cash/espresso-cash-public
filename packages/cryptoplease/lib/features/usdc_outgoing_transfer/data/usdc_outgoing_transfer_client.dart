import 'package:cryptoplease/config.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'usdc_outgoing_transfer_client.freezed.dart';
part 'usdc_outgoing_transfer_client.g.dart';

@RestApi()
abstract class UsdcOutgoingTransferClient {
  factory UsdcOutgoingTransferClient() => _UsdcOutgoingTransferClient(
        Dio(
          BaseOptions(baseUrl: usdcBaseUrl),
        ),
      );

  @POST('/createPayment')
  Future<CreatePaymentResponseDto> createPayment(
    @Queries() CreatePaymentRequestDto request,
  );
}

@freezed
class CreatePaymentRequestDto with _$CreatePaymentRequestDto {
  const factory CreatePaymentRequestDto({
    required String senderAccount,
    required String escrowAccount,
    required int amount,
  }) = _CreatePaymentRequestDto;

  factory CreatePaymentRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreatePaymentRequestDtoFromJson(json);
}

@freezed
class CreatePaymentResponseDto with _$CreatePaymentResponseDto {
  const factory CreatePaymentResponseDto({
    required String transaction,
  }) = _CreatePaymentResponseDto;

  factory CreatePaymentResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CreatePaymentResponseDtoFromJson(json);
}
