// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ambassador.freezed.dart';
part 'ambassador.g.dart';

@freezed
class AmbassadorReferralRequestDto with _$AmbassadorReferralRequestDto {
  const factory AmbassadorReferralRequestDto({
    required String ambassadorAddress,
  }) = _AmbassadorReferralRequestDto;

  factory AmbassadorReferralRequestDto.fromJson(Map<String, dynamic> json) =>
      _$AmbassadorReferralRequestDtoFromJson(json);
}

@freezed
class AmbassadorStatsResponseDto with _$AmbassadorStatsResponseDto {
  const factory AmbassadorStatsResponseDto({
    required int referralCount,
  }) = _AmbassadorStatsResponseDto;

  factory AmbassadorStatsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AmbassadorStatsResponseDtoFromJson(json);
}

@freezed
class AmbassadorVerificationResponseDto
    with _$AmbassadorVerificationResponseDto {
  const factory AmbassadorVerificationResponseDto({
    required bool isAmbassador,
    required bool isReferral,
  }) = _AmbassadorVerificationResponseDto;

  factory AmbassadorVerificationResponseDto.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$AmbassadorVerificationResponseDtoFromJson(json);
}
