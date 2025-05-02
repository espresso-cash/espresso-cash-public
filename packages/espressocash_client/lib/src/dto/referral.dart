import 'package:freezed_annotation/freezed_annotation.dart';

part 'referral.freezed.dart';

@freezed
class AmbassadorReferralRequestDto with _$AmbassadorReferralRequestDto {
  const factory AmbassadorReferralRequestDto({required String ambassadorAddress}) =
      _AmbassadorReferralRequestDto;
}

@freezed
class AmbassadorStatsResponseDto with _$AmbassadorStatsResponseDto {
  const factory AmbassadorStatsResponseDto({required int referralCount}) =
      _AmbassadorStatsResponseDto;
}

@freezed
class AmbassadorVerificationResponseDto with _$AmbassadorVerificationResponseDto {
  const factory AmbassadorVerificationResponseDto({
    required bool isAmbassador,
    required bool isReferral,
  }) = _AmbassadorVerificationResponseDto;
}
