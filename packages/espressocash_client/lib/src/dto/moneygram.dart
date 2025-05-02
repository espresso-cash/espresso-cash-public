import 'package:ec_client_dart/src/dto/ramp.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'moneygram.freezed.dart';

@freezed
class MoneygramChallengeSignRequestDto with _$MoneygramChallengeSignRequestDto {
  const factory MoneygramChallengeSignRequestDto({required String signedTx}) =
      _MoneygramChallengeSignRequestDto;
}

@freezed
class MoneygramChallengeSignResponseDto with _$MoneygramChallengeSignResponseDto {
  const factory MoneygramChallengeSignResponseDto({required String signedTx}) =
      _MoneygramChallengeSignResponseDto;
}

@freezed
class SwapToStellarRequestDto with _$SwapToStellarRequestDto {
  const factory SwapToStellarRequestDto({
    required String solanaSenderAddress,
    required String stellarReceiverAddress,
    required String amount,
    int? priorityFee,
  }) = _SwapToStellarRequestDto;
}

@freezed
class SwapToSolanaRequestDto with _$SwapToSolanaRequestDto {
  const factory SwapToSolanaRequestDto({
    required String stellarSenderAddress,
    required String solanaReceiverAddress,
    required String amount,
  }) = _SwapToSolanaRequestDto;
}

@freezed
class MoneygramSwapResponseDto with _$MoneygramSwapResponseDto {
  const factory MoneygramSwapResponseDto({required String encodedTx}) = _MoneygramSwapResponseDto;
}

@freezed
class MoneygramFeeRequestDto with _$MoneygramFeeRequestDto {
  const factory MoneygramFeeRequestDto({required String amount, required RampTypeDto type}) =
      _MoneygramFeeRequestDto;
}

@freezed
class MoneygramFeeResponseDto with _$MoneygramFeeResponseDto {
  const factory MoneygramFeeResponseDto({
    required String bridgeFee,
    required String moneygramFee,
    String? gasFeeInUsdc,
    int? priorityFee,
  }) = _MoneygramFeeResponseDto;
}

@freezed
class FundXlmRequestDto with _$FundXlmRequestDto {
  const factory FundXlmRequestDto({required String accountId}) = _FundXlmRequestDto;
}
