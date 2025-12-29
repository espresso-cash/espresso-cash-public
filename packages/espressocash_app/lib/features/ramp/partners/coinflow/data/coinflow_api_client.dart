// ignore_for_file: invalid_annotation_target, freezed compatibility

import 'package:dio/dio.dart' hide Headers;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../config.dart';

part 'coinflow_api_client.freezed.dart';
part 'coinflow_api_client.g.dart';

@injectable
@RestApi()
abstract class CoinflowClient {
  @factoryMethod
  factory CoinflowClient() => _CoinflowClient(Dio(BaseOptions(baseUrl: coinflowApiUrl)));

  @GET('/withdraw/history')
  @Headers(<String, dynamic>{'x-coinflow-auth-blockchain': 'solana'})
  Future<WithdrawHistoryResponseDto> getWithdrawalHistory(
    @Header('x-coinflow-auth-wallet') String walletId,
  );
}

@freezed
abstract class WithdrawHistoryResponseDto with _$WithdrawHistoryResponseDto {
  const factory WithdrawHistoryResponseDto({
    @Default([]) List<WithdrawHistoryResponseDataDto> withdraws,
  }) = _WithdrawHistoryResponseDto;

  factory WithdrawHistoryResponseDto.fromJson(Map<String, dynamic> data) =>
      _$WithdrawHistoryResponseDtoFromJson(data);
}

@freezed
abstract class WithdrawHistoryResponseDataDto with _$WithdrawHistoryResponseDataDto {
  const factory WithdrawHistoryResponseDataDto({
    required String transaction,
    @JsonKey(unknownEnumValue: CoinflowOrderStatus.unknown) required CoinflowOrderStatus status,
    required DateTime updatedAt,
  }) = _WithdrawHistoryResponseDataDto;

  factory WithdrawHistoryResponseDataDto.fromJson(Map<String, dynamic> data) =>
      _$WithdrawHistoryResponseDataDtoFromJson(data);
}

@JsonEnum()
enum CoinflowOrderStatus { completed, created, failed, pending, unknown }
