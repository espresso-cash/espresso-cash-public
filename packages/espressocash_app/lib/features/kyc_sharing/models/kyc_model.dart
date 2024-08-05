// ignore_for_file: invalid_annotation_target

import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

part 'kyc_model.freezed.dart';
part 'kyc_model.g.dart';

@freezed
class KycUserInfo with _$KycUserInfo {
  factory KycUserInfo({
    @JsonKey(name: 'DATA_INFO_FIRST_NAME') required String firstName,
    @JsonKey(name: 'DATA_INFO_MIDDLE_NAME') required String middleName,
    @JsonKey(name: 'DATA_INFO_LAST_NAME') required String lastName,
    @JsonKey(name: 'DATA_INFO_DOB') required String dob,
    @JsonKey(name: 'DATA_INFO_COUNTRY_CODE') required String countryCode,
    @JsonKey(name: 'DATA_INFO_ID_TYPE') required String idType,
    @JsonKey(name: 'DATA_INFO_ID_NUMBER') required String idNumber,
    @JsonKey(includeFromJson: false, includeToJson: false) File? photo,
  }) = _KycUserInfo;

  const KycUserInfo._();

  factory KycUserInfo.fromJson(Map<String, dynamic> json) =>
      _$KycUserInfoFromJson(json);

  Map<DataInfoKeys, String> toKycModel() => {
        DataInfoKeys.firstName: firstName,
        DataInfoKeys.middleName: middleName,
        DataInfoKeys.lastName: lastName,
        DataInfoKeys.dateOfBirth: dob,
        DataInfoKeys.countryCode: countryCode,
        DataInfoKeys.idType: idType,
        DataInfoKeys.idNumber: idNumber,
      };
}
