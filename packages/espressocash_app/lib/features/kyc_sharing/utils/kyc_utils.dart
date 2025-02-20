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

  // TODO(vs): This should be flexible for multiple documents
  IdType? get documentType => documents?.firstOrNull?.type;
  String? get documentNumber => documents?.firstOrNull?.number.nullIfEmpty;
  String? get countryCode => documents?.firstOrNull?.countryCode.nullIfEmpty;

  Uint8List? get photo => selfie?.value.let(Uint8List.fromList);

  // TODO(vs): This should be flexible for multiple bankInfos
  String? get bankCode => bankInfos?.firstOrNull?.bankCode.nullIfEmpty;
  String? get bankName => bankInfos?.firstOrNull?.bankName.nullIfEmpty;
  String? get accountNumber =>
      bankInfos?.firstOrNull?.accountNumber.nullIfEmpty;

  ValidationStatus get kycStatus {
    // TODO(vs): This should be flexible for multiple documents
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

  // TODO(vs): This should be flexible for multiple bankInfos
  bool get hasBankInfo =>
      (bankInfos?.firstOrNull?.bankCode.isNotEmpty ?? false) &&
      (bankInfos?.firstOrNull?.accountNumber.isNotEmpty ?? false) &&
      (bankInfos?.firstOrNull?.bankName.isNotEmpty ?? false);
}

extension StringNullIfEmpty on String {
  String? get nullIfEmpty => this.isEmpty ? null : this;
}
