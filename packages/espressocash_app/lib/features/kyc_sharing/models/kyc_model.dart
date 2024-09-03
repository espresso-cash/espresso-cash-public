// ignore_for_file: invalid_annotation_target

import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
part 'kyc_model.freezed.dart';
part 'kyc_model.g.dart';

@freezed
class KycUserInfo with _$KycUserInfo {
  factory KycUserInfo({
    required String firstName,
    required String middleName,
    required String lastName,
    required String dob,
    required String countryCode,
    required String idType,
    required String idNumber,
    @JsonKey(includeFromJson: false, includeToJson: false) File? photo,
  }) = _KycUserInfo;

  const KycUserInfo._();

  factory KycUserInfo.fromJson(Map<String, dynamic> json) =>
      _$KycUserInfoFromJson(json);
}
