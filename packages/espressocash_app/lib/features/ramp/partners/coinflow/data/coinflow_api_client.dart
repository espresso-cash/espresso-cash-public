// ignore_for_file: invalid_annotation_target

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
  factory CoinflowClient() =>
      _CoinflowClient(Dio(BaseOptions(baseUrl: coinflowApiUrl)));

  @GET('/withdraw/history')
  @Headers(<String, dynamic>{'x-coinflow-auth-blockchain': 'solana'})
  Future<WithdrawHistoryResponseDto> getWithdrawalHistory(
    @Header('x-coinflow-auth-wallet') String walletId,
  );

  @GET('/withdraw')
  @Headers(<String, dynamic>{'x-coinflow-auth-blockchain': 'solana'})
  Future<WithdrawerResponseDto> getWithdrawer(
    @Header('x-coinflow-auth-wallet') String walletId,
  );
}

@freezed
class WithdrawHistoryResponseDto with _$WithdrawHistoryResponseDto {
  const factory WithdrawHistoryResponseDto({
    @Default([]) List<WithdrawHistoryResponseDataDto> withdraws,
  }) = _WithdrawHistoryResponseDto;

  factory WithdrawHistoryResponseDto.fromJson(Map<String, dynamic> data) =>
      _$WithdrawHistoryResponseDtoFromJson(data);
}

@freezed
class WithdrawHistoryResponseDataDto with _$WithdrawHistoryResponseDataDto {
  const factory WithdrawHistoryResponseDataDto({
    required String transaction,
    @JsonKey(unknownEnumValue: CoinflowOrderStatus.unknown)
    required CoinflowOrderStatus status,
    required DateTime updatedAt,
  }) = _WithdrawHistoryResponseDataDto;

  factory WithdrawHistoryResponseDataDto.fromJson(Map<String, dynamic> data) =>
      _$WithdrawHistoryResponseDataDtoFromJson(data);
}

@freezed
class WithdrawerResponseDto with _$WithdrawerResponseDto {
  const factory WithdrawerResponseDto({
    required WithdrawerDto withdrawer,
  }) = _WithdrawerResponseDto;
  factory WithdrawerResponseDto.fromJson(Map<String, dynamic> data) =>
      _$WithdrawerResponseDtoFromJson(data);
}

@freezed
class WithdrawerDto with _$WithdrawerDto {
  const factory WithdrawerDto({
    required bool isBlocked,
    required String currency,
    String? email,
    @Default([]) List<dynamic> bankAccounts,
    @Default([]) List<dynamic> cards,
    @Default([]) List<dynamic> ibans,
  }) = _WithdrawerDto;

  const WithdrawerDto._();

  factory WithdrawerDto.fromJson(Map<String, dynamic> data) =>
      _$WithdrawerDtoFromJson(data);

  bool get hasLinkedAccounts =>
      bankAccounts.isNotEmpty || cards.isNotEmpty || ibans.isNotEmpty;
}

@JsonEnum()
enum CoinflowOrderStatus {
  completed,
  created,
  failed,
  pending,
  unknown,
}
