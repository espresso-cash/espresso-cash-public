import 'package:freezed_annotation/freezed_annotation.dart';

part 'moneygram.freezed.dart';
part 'moneygram.g.dart';

@freezed
class MoneygramDepositRequestDto with _$MoneygramDepositRequestDto {
  const factory MoneygramDepositRequestDto({
    required String signedTx,
    required String account,
    required String amount,
    required String lang,
  }) = _MoneygramDepositRequestDto;

  factory MoneygramDepositRequestDto.fromJson(Map<String, dynamic> json) =>
      _$MoneygramDepositRequestDtoFromJson(json);
}

@freezed
class MoneygramDepositResponseDto with _$MoneygramDepositResponseDto {
  const factory MoneygramDepositResponseDto({
    required String id,
    required String url,
    required String token,
  }) = _MoneygramDepositResponseDto;

  factory MoneygramDepositResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MoneygramDepositResponseDtoFromJson(json);
}
