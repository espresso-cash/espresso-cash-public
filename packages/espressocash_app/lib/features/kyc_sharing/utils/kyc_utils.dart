import 'dart:typed_data';

import 'package:dfunc/dfunc.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

extension ValidationStatusExtension on ValidationStatus {
  bool get isApprovedOrPending =>
      this == ValidationStatus.approved || this == ValidationStatus.pending;

  bool get isUnspecified => this == ValidationStatus.unspecified;
}

extension UserDataExtensions on UserData {
  String? get firstName => name?.firstName.nullIfEmpty;
  String? get lastName => name?.lastName.nullIfEmpty;
  DateTime? get dob => birthDate?.value;
  String? get citizenshipCode => citizenship?.value.nullIfEmpty;

  String? get getEmail => email?.value.nullIfEmpty;
  String? get getPhone => phone?.value.nullIfEmpty;

  Uint8List? get photo => selfie?.value.let(Uint8List.fromList);

  ValidationStatus get phoneStatus =>
      phone?.status ?? ValidationStatus.unspecified;
  ValidationStatus get emailStatus =>
      email?.status ?? ValidationStatus.unspecified;

  bool hasBankInfo(BankInfo bankInfo) =>
      bankInfo.bankCode.isNotEmpty &&
      bankInfo.accountNumber.isNotEmpty &&
      bankInfo.bankName.isNotEmpty;
}

extension StringNullIfEmpty on String {
  String? get nullIfEmpty => this.isEmpty ? null : this;
}
