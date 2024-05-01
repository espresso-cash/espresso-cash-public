import 'package:freezed_annotation/freezed_annotation.dart';

part 'durable_transactions.g.dart';
part 'durable_transactions.freezed.dart';

@freezed
class GetFreeNonceResponseDto with _$GetFreeNonceResponseDto {
  const factory GetFreeNonceResponseDto({
    required String nonce,
    required String nonceAccount,
    required String authority,
  }) = _GetFreeNonceResponseDto;

  factory GetFreeNonceResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GetFreeNonceResponseDtoFromJson(json);
}

@freezed
class SubmitDurableTxRequestDto with _$SubmitDurableTxRequestDto {
  const factory SubmitDurableTxRequestDto({
    required String tx,
  }) = _SubmitDurableTxRequestDto;

  factory SubmitDurableTxRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SubmitDurableTxRequestDtoFromJson(json);
}
