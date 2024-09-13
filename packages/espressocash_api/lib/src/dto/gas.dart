import 'package:freezed_annotation/freezed_annotation.dart';

part 'gas.freezed.dart';
part 'gas.g.dart';

@freezed
class GasFeeRequestDto with _$GasFeeRequestDto {
  const factory GasFeeRequestDto({
    required String network,
  }) = _GasFeeRequestDto;

  factory GasFeeRequestDto.fromJson(Map<String, dynamic> json) =>
      _$GasFeeRequestDtoFromJson(json);
}

@freezed
class GasFeeResponseDto with _$GasFeeResponseDto {
  const factory GasFeeResponseDto({
    required GasFeeEstimate low,
    required GasFeeEstimate medium,
    required GasFeeEstimate high,
    required String estimatedBaseFee,
    required double networkCongestion,
  }) = _GasFeeResponseDto;

  factory GasFeeResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GasFeeResponseDtoFromJson(json);
}

@freezed
class GasFeeEstimate with _$GasFeeEstimate {
  factory GasFeeEstimate({
    required String suggestedMaxPriorityFeePerGas,
    required String suggestedMaxFeePerGas,
    required int minWaitTimeEstimate,
    required int maxWaitTimeEstimate,
  }) = _GasFeeEstimate;

  factory GasFeeEstimate.fromJson(Map<String, dynamic> json) =>
      _$GasFeeEstimateFromJson(json);
}
