import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:dfunc/dfunc.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

extension ValidationStatusExtension on ValidationStatus {
  bool get isApprovedOrPending =>
      this == ValidationStatus.approved || this == ValidationStatus.pending;
}

extension UserDataExtensions on UserData {
  String get firstName => name?.first.firstName ?? '';
  String get lastName => name?.first.lastName ?? '';
  DateTime get dob => birthDate?.first.value ?? DateTime.now();

  String get getEmail => email?.first.value ?? '';
  String get getPhone => phone?.first.value ?? '';

  IdType get documentType => document?.first.type ?? IdType.other;
  String get documentNumber => document?.first.number ?? '';
  String get countryCode => document?.first.countryCode ?? '';

  Uint8List? get photo => selfie?.first.value.let(Uint8List.fromList);

  String get bankCode => bankInfo?.first.bankCode ?? '';
  String get bankName => bankInfo?.first.bankName ?? '';
  String get accountNumber => bankInfo?.first.accountNumber ?? '';

  ValidationStatus get kycStatus {
    final statuses = [
      document?.first.status,
      name?.first.status,
      selfie?.first.status,
      birthDate?.first.status,
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
      phone?.first.status ?? ValidationStatus.unspecified;
  ValidationStatus get emailStatus =>
      email?.first.status ?? ValidationStatus.unspecified;

  bool get hasBankInfo =>
      (bankInfo?.first.bankCode.isNotEmpty ?? false) &&
      (bankInfo?.first.accountNumber.isNotEmpty ?? false) &&
      (bankInfo?.first.bankName.isNotEmpty ?? false);
}
