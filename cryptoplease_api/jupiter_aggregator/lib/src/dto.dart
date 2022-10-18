// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jupiter_aggregator/jupiter_aggregator.dart';

part 'dto.freezed.dart';
part 'dto.g.dart';

@freezed
class QuoteRequestDto with _$QuoteRequestDto {
  /// [inputMint] input token mint
  /// [outputMint] output token mint
  /// [amount] input token amount
  /// [slippage] slippage tolerance (percent)
  /// [feeBps] host fee bps
  const factory QuoteRequestDto({
    required String inputMint,
    required String outputMint,
    required int amount,
    @Default(SwapMode.exactIn) SwapMode swapMode,
    @JsonKey(includeIfNull: false) double? slippage,
    @JsonKey(includeIfNull: false) double? feeBps,
  }) = _QuoteRequestDto;

  factory QuoteRequestDto.fromJson(Map<String, dynamic> json) =>
      _$QuoteRequestDtoFromJson(json);
}

@freezed
class QuoteResponseDto with _$QuoteResponseDto {
  const factory QuoteResponseDto({
    @JsonKey(name: 'data') required List<JupiterRoute> routes,
  }) = _QuoteResponseDto;

  factory QuoteResponseDto.fromJson(Map<String, dynamic> json) =>
      _$QuoteResponseDtoFromJson(json);
}

@freezed
class SwapRequestDto with _$SwapRequestDto {
  /// [userPublicKey] swap user public key
  /// [route] route (@see getQuote)
  const factory SwapRequestDto({
    required String userPublicKey,
    required JupiterRoute route,
  }) = _SwapRequestDto;

  factory SwapRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SwapRequestDtoFromJson(json);
}
