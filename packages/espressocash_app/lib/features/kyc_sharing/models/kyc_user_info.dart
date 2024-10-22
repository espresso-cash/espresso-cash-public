// ignore_for_file: invalid_annotation_target

import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

part 'kyc_user_info.freezed.dart';

@freezed
class KycUserInfo with _$KycUserInfo {
  factory KycUserInfo({
    required String email,
    required String phone,
    required String firstName,
    required String lastName,
    required DateTime dob,
    required String countryCode,
    required String idType,
    required String idNumber,
    required String bankName,
    required String bankAccountNumber,
    required String bankCode,
    required Uint8List? photoSelfie,
    required ValidationStatus kycStatus,
    required ValidationStatus phoneStatus,
    required ValidationStatus emailStatus,
  }) = _KycUserInfo;

  const KycUserInfo._();
}

extension KycUserInfoExtensions on KycUserInfo {
  bool get hasBankInfo => bankAccountNumber.isNotEmpty && bankCode.isNotEmpty;
}

