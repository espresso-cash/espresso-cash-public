import 'package:freezed_annotation/freezed_annotation.dart';

part 'durable_transactions.freezed.dart';
part 'durable_transactions.g.dart';

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

@freezed
class SubmitDurableTxResponseDto with _$SubmitDurableTxResponseDto {
  const factory SubmitDurableTxResponseDto({
    required String signature,
  }) = _SubmitDurableTxResponseDto;

  factory SubmitDurableTxResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SubmitDurableTxResponseDtoFromJson(json);
}

@freezed
class GetDurableFeesResponseDto with _$GetDurableFeesResponseDto {
  const factory GetDurableFeesResponseDto({
    required int outgoingLink,
    required int incomingLink,
    required int cancelLink,
  }) = _GetDurableFeesResponseDto;

  factory GetDurableFeesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GetDurableFeesResponseDtoFromJson(json);
}
