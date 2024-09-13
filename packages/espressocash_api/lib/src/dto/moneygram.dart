import 'package:freezed_annotation/freezed_annotation.dart';

part 'moneygram.freezed.dart';
part 'moneygram.g.dart';

@freezed
class MoneygramChallengeSignRequestDto with _$MoneygramChallengeSignRequestDto {
  const factory MoneygramChallengeSignRequestDto({
    required String signedTx,
  }) = _MoneygramChallengeSignRequestDto;

  factory MoneygramChallengeSignRequestDto.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$MoneygramChallengeSignRequestDtoFromJson(json);
}

@freezed
class MoneygramChallengeSignResponseDto
    with _$MoneygramChallengeSignResponseDto {
  const factory MoneygramChallengeSignResponseDto({
    required String signedTx,
  }) = _MoneygramChallengeSignResponseDto;

  factory MoneygramChallengeSignResponseDto.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$MoneygramChallengeSignResponseDtoFromJson(json);
}

@freezed
class SwapToStellarRequestDto with _$SwapToStellarRequestDto {
  const factory SwapToStellarRequestDto({
    required String solanaSenderAddress,
    required String stellarReceiverAddress,
    required String amount,
  }) = _SwapToStellarRequestDto;

  factory SwapToStellarRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SwapToStellarRequestDtoFromJson(json);
}

@freezed
class SwapToSolanaRequestDto with _$SwapToSolanaRequestDto {
  const factory SwapToSolanaRequestDto({
    required String stellarSenderAddress,
    required String solanaReceiverAddress,
    required String amount,
  }) = _SwapToSolanaRequestDto;

  factory SwapToSolanaRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SwapToSolanaRequestDtoFromJson(json);
}

@freezed
class MoneygramSwapResponseDto with _$MoneygramSwapResponseDto {
  const factory MoneygramSwapResponseDto({
    required String encodedTx,
  }) = _MoneygramSwapResponseDto;

  factory MoneygramSwapResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MoneygramSwapResponseDtoFromJson(json);
}

@freezed
class MoneygramFeeRequestDto with _$MoneygramFeeRequestDto {
  const factory MoneygramFeeRequestDto({
    required String amount,
    required RampTypeDto type,
  }) = _MoneygramFeeRequestDto;

  factory MoneygramFeeRequestDto.fromJson(Map<String, dynamic> json) =>
      _$MoneygramFeeRequestDtoFromJson(json);
}

@freezed
class MoneygramFeeResponseDto with _$MoneygramFeeResponseDto {
  const factory MoneygramFeeResponseDto({
    required String totalAmount,
    required String bridgeFee,
    required String moneygramFee,
  }) = _MoneygramFeeResponseDto;

  factory MoneygramFeeResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MoneygramFeeResponseDtoFromJson(json);
}

enum RampTypeDto { onRamp, offRamp }

@freezed
class FundXlmRequestDto with _$FundXlmRequestDto {
  const factory FundXlmRequestDto({
    required String accountId,
  }) = _FundXlmRequestDto;

  factory FundXlmRequestDto.fromJson(Map<String, dynamic> json) =>
      _$FundXlmRequestDtoFromJson(json);
}
