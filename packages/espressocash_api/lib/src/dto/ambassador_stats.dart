import 'package:freezed_annotation/freezed_annotation.dart';

part 'ambassador_stats.freezed.dart';
part 'ambassador_stats.g.dart';

@freezed
class AmbassadorStatsResponseDto with _$AmbassadorStatsResponseDto {
  const factory AmbassadorStatsResponseDto({
    required int referralCount,
  }) = _AmbassadorStatsResponseDto;

  factory AmbassadorStatsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AmbassadorStatsResponseDtoFromJson(json);
}
