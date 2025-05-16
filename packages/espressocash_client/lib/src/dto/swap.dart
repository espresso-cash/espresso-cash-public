import 'package:freezed_annotation/freezed_annotation.dart';

part 'swap.freezed.dart';

enum SwapMatchDto { inAmount, outAmount }

enum SwapSlippageDto { zpOne, zpFive, onePercent }

@freezed
class SwapRouteRequestDto with _$SwapRouteRequestDto {
  const factory SwapRouteRequestDto({
    required String inputToken,
    required String outputToken,
    required String amount,
    required SwapMatchDto match,
    required SwapSlippageDto slippage,
  }) = _SwapRouteRequestDto;
}

@freezed
class SwapRouteResponseDto with _$SwapRouteResponseDto {
  const factory SwapRouteResponseDto({
    required String inAmount,
    required String outAmount,
    required String amount,
    required String encodedTx,
    required int feeInUsdc,
    required BigInt slot,
    required int slippageBps,
    required int platformFeeBps,
    required String priceImpact,
    required String providerLabel,
  }) = _SwapRouteResponseDto;
}
