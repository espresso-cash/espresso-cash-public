import 'package:freezed_annotation/freezed_annotation.dart';

part 'fiat_rate.freezed.dart';
part 'fiat_rate.g.dart';

@freezed
class FiatRateRequestDto with _$FiatRateRequestDto {
  const factory FiatRateRequestDto({
    required String base,
    required String target,
  }) = _FiatRateRequestDto;

  factory FiatRateRequestDto.fromJson(Map<String, dynamic> json) =>
      _$FiatRateRequestDtoFromJson(json);
}

@freezed
class FiatRateResponseDto with _$FiatRateResponseDto {
  const factory FiatRateResponseDto({
    required double rate,
  }) = _FiatRateResponseDto;

  factory FiatRateResponseDto.fromJson(Map<String, dynamic> json) =>
      _$FiatRateResponseDtoFromJson(json);
}
