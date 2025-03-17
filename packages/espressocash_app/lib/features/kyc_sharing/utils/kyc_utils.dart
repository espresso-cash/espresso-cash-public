import 'dart:typed_data';

import 'package:collection/collection.dart';
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

  // TODO(vs): Implement new status fetching for kyc fields
  ValidationStatus get kycStatus {
    final statuses = [
      documents?.firstOrNull?.status,
      name?.status,
      selfie?.status,
      birthDate?.status,
    ].whereNotNull().toList();

    if (statuses.isEmpty) return ValidationStatus.unspecified;

    if (statuses.any((s) => s == ValidationStatus.rejected)) {
      return ValidationStatus.rejected;
    }

    if (statuses.any((s) => s == ValidationStatus.pending)) {
      return ValidationStatus.pending;
    }

    return statuses.every((s) => s == ValidationStatus.approved)
        ? ValidationStatus.approved
        : ValidationStatus.unspecified;
  }

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
