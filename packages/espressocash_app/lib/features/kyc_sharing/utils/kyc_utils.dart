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

  String? get getEmail => email?.value.nullIfEmpty;
  String? get getPhone => phone?.value.nullIfEmpty;

  IdType? get documentType => document?.type;
  String? get documentNumber => document?.number.nullIfEmpty;
  String? get countryCode => document?.countryCode.nullIfEmpty;

  Uint8List? get photo => selfie?.value.let(Uint8List.fromList);

  String? get bankCode => bankInfo?.bankCode.nullIfEmpty;
  String? get bankName => bankInfo?.bankName.nullIfEmpty;
  String? get accountNumber => bankInfo?.accountNumber.nullIfEmpty;

  ValidationStatus get kycStatus {
    final statuses = [
      document?.status,
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

  bool get hasBankInfo =>
      (bankInfo?.bankCode.isNotEmpty ?? false) &&
      (bankInfo?.accountNumber.isNotEmpty ?? false) &&
      (bankInfo?.bankName.isNotEmpty ?? false);
}

extension StringNullIfEmpty on String {
  String? get nullIfEmpty => this.isEmpty ? null : this;
}

extension IdTypeExtension on IdType {
  String get name => switch (this) {
        IdType.voterId => 'Voter ID',
        IdType.passport => 'Passport',
        IdType.driverLicense => 'Driver License',
        IdType.other => 'Other',
      };
}
