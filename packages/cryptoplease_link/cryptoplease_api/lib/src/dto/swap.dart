import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'swap.freezed.dart';
part 'swap.g.dart';

enum SwapMatch { inAmount, outAmount }

enum SwapSlippage { zpOne, zpFive, onePercent }

@freezed
class SwapRouteRequestDto with _$SwapRouteRequestDto {
  const factory SwapRouteRequestDto({
    required String inputToken,
    required String outputToken,
    required String amount,
    required SwapMatch match,
    required SwapSlippage slippage,
    required String userAccount,
  }) = _SwapRouteRequestDto;

  factory SwapRouteRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SwapRouteRequestDtoFromJson(json);
}

@freezed
class SwapRouteResponseDto with _$SwapRouteResponseDto {
  const factory SwapRouteResponseDto({
    required JupiterRoute? bestRoute,
    required int feeInUsdc,
  }) = _SwapRouteResponseDto;

  factory SwapRouteResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SwapRouteResponseDtoFromJson(json);
}

@freezed
class SwapTxResponseDto with _$SwapTxResponseDto {
  const factory SwapTxResponseDto({
    required String swapTransaction,
  }) = _SwapTxResponseDto;

  factory SwapTxResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SwapTxResponseDtoFromJson(json);
}

@freezed
class SwapTxRequestDto with _$SwapTxRequestDto {
  const factory SwapTxRequestDto({
    required String userAccount,
    required JupiterRoute route,
  }) = _SwapTxRequestDto;

  factory SwapTxRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SwapTxRequestDtoFromJson(json);
}
