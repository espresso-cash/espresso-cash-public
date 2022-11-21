import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_swap_fee.freezed.dart';
part 'get_swap_fee.g.dart';

@freezed
class GetSwapFeeResponseDto with _$GetSwapFeeResponseDto {
  const factory GetSwapFeeResponseDto({
    required int feeInUsdc,
  }) = _GetSwapFeeResponseDto;

  factory GetSwapFeeResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GetSwapFeeResponseDtoFromJson(json);
}

@freezed
class GetSwapFeeRequestDto with _$GetSwapFeeRequestDto {
  const factory GetSwapFeeRequestDto({
    required JupiterRoute route,
  }) = _GetSwapFeeRequestDto;

  factory GetSwapFeeRequestDto.fromJson(Map<String, dynamic> json) =>
      _$GetSwapFeeRequestDtoFromJson(json);
}
