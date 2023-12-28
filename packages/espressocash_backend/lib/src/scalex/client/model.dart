// ignore_for_file: invalid_annotation_target

import 'package:dfunc/dfunc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class GenerateIFrameBodyDto with _$GenerateIFrameBodyDto {
  const factory GenerateIFrameBodyDto({
    required String type,
    required String address,
    required String email,
    required String token,
    required String network,
  }) = _GenerateIFrameBodyDto;

  factory GenerateIFrameBodyDto.fromJson(Map<String, dynamic> json) =>
      _$GenerateIFrameBodyDtoFromJson(json);
}

@Freezed(genericArgumentFactories: true, toJson: false)
class ScalexResponseDto<T> with _$ScalexResponseDto<T> {
  const factory ScalexResponseDto({
    required T data,
  }) = _ScalexResponseDto<T>;

  factory ScalexResponseDto.fromJson(
    Map<String, dynamic> json,
    Transformer<Object?, T> fromJsonT,
  ) =>
      _$ScalexResponseDtoFromJson(json, fromJsonT);
}

@freezed
class GenerateIFrameDto with _$GenerateIFrameDto {
  const factory GenerateIFrameDto({
    required String link,
    required String environment,
  }) = _GenerateIFrameResponseDto;

  factory GenerateIFrameDto.fromJson(Map<String, dynamic> json) =>
      _$GenerateIFrameDtoFromJson(json);
}

@Freezed(toJson: false)
class TransactionDto with _$TransactionDto {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TransactionDto({
    @JsonKey(unknownEnumValue: OrderStatus.unknown) required OrderStatus status,
    required String type,
    required String fromCurrency,
    required num fromAmount,
    BankInfoDto? bankToFund,
  }) = _TransactionDto;

  factory TransactionDto.fromJson(Map<String, dynamic> json) =>
      _$TransactionDtoFromJson(json);
}

@freezed
class BankInfoDto with _$BankInfoDto {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory BankInfoDto({
    required String bankName,
    required String accountNumber,
  }) = _PaymentDto;

  factory BankInfoDto.fromJson(Map<String, dynamic> json) =>
      _$BankInfoDtoFromJson(json);
}

@JsonEnum()
enum OrderStatus {
  pending,
  completed,
  expired,
  failed,
  unknown,
}
