import 'package:freezed_annotation/freezed_annotation.dart';

part 'ambassador_referral.freezed.dart';
part 'ambassador_referral.g.dart';

@freezed
class AmbassadorReferralRequestDto with _$AmbassadorReferralRequestDto {
  const factory AmbassadorReferralRequestDto({
    required String ambassadorAddress,
    required String userAddress,
  }) = _AmbassadorReferralRequestDto;

  factory AmbassadorReferralRequestDto.fromJson(Map<String, dynamic> json) =>
      _$AmbassadorReferralRequestDtoFromJson(json);
}
