import 'package:ec_client_dart/src/dto/ramp.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'moneygram.freezed.dart';

@freezed
sealed class MoneygramChallengeSignRequestDto with _$MoneygramChallengeSignRequestDto {
  const factory MoneygramChallengeSignRequestDto({required String signedTx}) =
      _MoneygramChallengeSignRequestDto;
}

@freezed
sealed class MoneygramChallengeSignResponseDto with _$MoneygramChallengeSignResponseDto {
  const factory MoneygramChallengeSignResponseDto({required String signedTx}) =
      _MoneygramChallengeSignResponseDto;
}

@freezed
sealed class SwapToStellarRequestDto with _$SwapToStellarRequestDto {
  const factory SwapToStellarRequestDto({
    required String solanaSenderAddress,
    required String stellarReceiverAddress,
    required String amount,
    int? priorityFee,
  }) = _SwapToStellarRequestDto;
}

@freezed
sealed class SwapToSolanaRequestDto with _$SwapToSolanaRequestDto {
  const factory SwapToSolanaRequestDto({
    required String stellarSenderAddress,
    required String solanaReceiverAddress,
    required String amount,
  }) = _SwapToSolanaRequestDto;
}

@freezed
sealed class MoneygramSwapResponseDto with _$MoneygramSwapResponseDto {
  const factory MoneygramSwapResponseDto({required String encodedTx}) = _MoneygramSwapResponseDto;
}

@freezed
sealed class MoneygramFeeRequestDto with _$MoneygramFeeRequestDto {
  const factory MoneygramFeeRequestDto({required String amount, required RampTypeDto type}) =
      _MoneygramFeeRequestDto;
}

@freezed
sealed class MoneygramFeeResponseDto with _$MoneygramFeeResponseDto {
  const factory MoneygramFeeResponseDto({
    required String bridgeFee,
    required String moneygramFee,
    String? gasFeeInUsdc,
    int? priorityFee,
  }) = _MoneygramFeeResponseDto;
}

@freezed
sealed class FundXlmRequestDto with _$FundXlmRequestDto {
  const factory FundXlmRequestDto({required String accountId}) = _FundXlmRequestDto;
}
