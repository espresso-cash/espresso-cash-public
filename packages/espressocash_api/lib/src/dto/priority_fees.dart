import 'package:freezed_annotation/freezed_annotation.dart';

part 'priority_fees.freezed.dart';
part 'priority_fees.g.dart';

@freezed
class PriorityFeesRequestDto with _$PriorityFeesRequestDto {
  const factory PriorityFeesRequestDto({
    required String encodedTx,
  }) = _PriorityFeesRequestDto;

  factory PriorityFeesRequestDto.fromJson(Map<String, dynamic> json) =>
      _$PriorityFeesRequestDtoFromJson(json);
}

@freezed
class PriorityFeesResponseDto with _$PriorityFeesResponseDto {
  const factory PriorityFeesResponseDto({
    int? none,
    int? low,
    int? medium,
    int? high,
    int? veryHigh,
    int? unsafeMax,
  }) = _PriorityFeesResponseDto;

  factory PriorityFeesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$PriorityFeesResponseDtoFromJson(json);
}
