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
