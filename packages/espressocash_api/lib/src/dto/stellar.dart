import 'package:freezed_annotation/freezed_annotation.dart';
part 'stellar.freezed.dart';
part 'stellar.g.dart';

@freezed
class MoneygramDepositRequestDto with _$MoneygramDepositRequestDto {
  const factory MoneygramDepositRequestDto({
    required String signedTx,
    required String account,
    required String amount,
    required String lang,
  }) = _MoneygramDepositRequestDto;

  factory MoneygramDepositRequestDto.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$MoneygramDepositRequestDtoFromJson(json);
}

@freezed
class MoneygramDepositResponseDto with _$MoneygramDepositResponseDto {
  const factory MoneygramDepositResponseDto({
    required String url,
    required String id,
  }) = _MoneygramDepositResponseDto;

  factory MoneygramDepositResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MoneygramDepositResponseDtoFromJson(json);
}
