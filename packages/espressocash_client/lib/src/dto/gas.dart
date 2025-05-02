import 'package:freezed_annotation/freezed_annotation.dart';

part 'gas.freezed.dart';

@freezed
class GasFeeRequestDto with _$GasFeeRequestDto {
  const factory GasFeeRequestDto({required String network}) = _GasFeeRequestDto;
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
}

@freezed
class GasFeeEstimate with _$GasFeeEstimate {
  factory GasFeeEstimate({
    required String suggestedMaxPriorityFeePerGas,
    required String suggestedMaxFeePerGas,
    required int minWaitTimeEstimate,
    required int maxWaitTimeEstimate,
  }) = _GasFeeEstimate;
}
