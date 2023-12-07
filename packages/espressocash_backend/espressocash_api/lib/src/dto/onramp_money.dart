import 'package:freezed_annotation/freezed_annotation.dart';

part 'onramp_money.freezed.dart';
part 'onramp_money.g.dart';

@freezed
class GenerateOnRampTokenResponseDto with _$GenerateOnRampTokenResponseDto {
  const factory GenerateOnRampTokenResponseDto({
    required String token,
    required String depositAddress,
  }) = _GenerateOnRampTokenResponseDto;

  factory GenerateOnRampTokenResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GenerateOnRampTokenResponseDtoFromJson(json);
}

@freezed
class GenerateOnRampTokenRequestDto with _$GenerateOnRampTokenRequestDto {
  const factory GenerateOnRampTokenRequestDto({
    required String message,
    required String signedMessage,
    required String walletAddress,
    required DateTime timestamp,
    required String quantity,
    required String appId,
  }) = _GenerateOnRampTokenRequestDto;

  factory GenerateOnRampTokenRequestDto.fromJson(Map<String, dynamic> json) =>
      _$GenerateOnRampTokenRequestDtoFromJson(json);
}

@freezed
class OrderStatusOrmRequestDto with _$OrderStatusOrmRequestDto {
  const factory OrderStatusOrmRequestDto({
    required String referenceId,
  }) = _OrderStatusOrmRequestDto;

  factory OrderStatusOrmRequestDto.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusOrmRequestDtoFromJson(json);
}

@freezed
class OrderStatusOrmResponseDto with _$OrderStatusOrmResponseDto {
  //TODO update fields
  const factory OrderStatusOrmResponseDto({
    required int status,
  }) = _OrderStatusOrmResponseDto;

  factory OrderStatusOrmResponseDto.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusOrmResponseDtoFromJson(json);
}
