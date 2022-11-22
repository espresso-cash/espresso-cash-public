import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'swap.freezed.dart';
part 'swap.g.dart';

@freezed
class SwapResponseDto with _$SwapResponseDto {
  const factory SwapResponseDto({
    required String swapTransaction,
  }) = _SwapResponseDto;

  factory SwapResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SwapResponseDtoFromJson(json);
}

@freezed
class SwapRequestDto with _$SwapRequestDto {
  const factory SwapRequestDto({
    required String userPublicKey,
    required JupiterRoute route,
  }) = _SwapRequestDto;

  factory SwapRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SwapRequestDtoFromJson(json);
}
