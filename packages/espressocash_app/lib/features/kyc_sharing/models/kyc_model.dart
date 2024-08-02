import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

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
