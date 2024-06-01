import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_rates.freezed.dart';
part 'get_rates.g.dart';

@freezed
class GetRatesResponseDto with _$GetRatesResponseDto {
  const factory GetRatesResponseDto({
    required double usdc,
  }) = _GetRatesResponseDto;

  factory GetRatesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GetRatesResponseDtoFromJson(json);
}
