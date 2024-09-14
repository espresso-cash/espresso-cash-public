// ignore_for_file: invalid_annotation_target

import 'dart:typed_data';

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
    required String email,
    required String phone,
    required String bankAccountNumber,
    required String bankCode,
    @JsonKey(includeFromJson: false, includeToJson: false)
    Uint8List? photoIdCard,
    @JsonKey(includeFromJson: false, includeToJson: false)
    Uint8List? photoSelfie,
  }) = _KycUserInfo;

  const KycUserInfo._();

  factory KycUserInfo.fromJson(Map<String, dynamic> json) =>
      _$KycUserInfoFromJson(json);
}

extension KycUserInfoExtensions on KycUserInfo {
  bool get hasBankInfo => bankAccountNumber.isNotEmpty && bankCode.isNotEmpty;
}
