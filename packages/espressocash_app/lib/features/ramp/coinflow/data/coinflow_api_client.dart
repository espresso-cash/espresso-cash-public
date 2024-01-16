// ignore_for_file: invalid_annotation_target

import 'package:dio/dio.dart' hide Headers;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../config.dart';

part 'coinflow_api_client.freezed.dart';
part 'coinflow_api_client.g.dart';

@injectable
@RestApi()
abstract class CoinflowClient {
  @factoryMethod
  factory CoinflowClient() =>
      _CoinflowClient(Dio(BaseOptions(baseUrl: coinflowApiUrl)));

  @GET('/withdraw/history')
  @Headers(<String, dynamic>{'x-coinflow-auth-blockchain': 'solana'})
  Future<WithdrawResponseDto> getWithdrawalHistory(
    @Header('x-coinflow-auth-wallet') String walletId,
  );
}

@freezed
class WithdrawResponseDto with _$WithdrawResponseDto {
  const factory WithdrawResponseDto({
    @Default([]) List<WithdrawResponseDataDto> withdraws,
  }) = _WithdrawResponseDto;

  factory WithdrawResponseDto.fromJson(Map<String, dynamic> data) =>
      _$WithdrawResponseDtoFromJson(data);
}

@freezed
class WithdrawResponseDataDto with _$WithdrawResponseDataDto {
  const factory WithdrawResponseDataDto({
    required String transaction,
    @JsonKey(unknownEnumValue: CoinflowOrderStatus.unknown)
    required CoinflowOrderStatus status,
    required DateTime updatedAt,
  }) = _WithdrawResponseDataDto;

  factory WithdrawResponseDataDto.fromJson(Map<String, dynamic> data) =>
      _$WithdrawResponseDataDtoFromJson(data);
}

@JsonEnum()
enum CoinflowOrderStatus {
  completed,
  created,
  failed,
  pending,
  unknown,
}
