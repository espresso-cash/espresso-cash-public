import 'dart:typed_data';

import 'package:brij_client/brij_client.dart';
import 'package:collection/collection.dart';
import 'package:dfunc/dfunc.dart';

import '../models/kyc_validation_status.dart';

extension UserDataExtensions on UserData {
  String? get firstName => name?.firstName.nullIfEmpty;
  String? get lastName => name?.lastName.nullIfEmpty;
  DateTime? get dob => birthDate?.value;
  String? get citizenshipCode => citizenship?.value.nullIfEmpty;

  String? get emailValue => email?.value.nullIfEmpty;
  String? get phoneValue => phone?.value.nullIfEmpty;

  Uint8List? get photo => selfie?.value.let(Uint8List.fromList);

  BankInfo? getBankByCountry(String country) =>
      bankInfos?.firstWhereOrNull((bank) => bank.countryCode == country);

  List<Document>? getDocumentsByCountryGroup(List<String> countryGroups) =>
      documents?.where((document) => countryGroups.contains(document.countryCode)).toList();

  KycValidationStatus get phoneStatus =>
      phone?.status.toKycValidationStatus() ?? KycValidationStatus.unverified;
  KycValidationStatus get emailStatus =>
      email?.status.toKycValidationStatus() ?? KycValidationStatus.unverified;

  bool hasBankInfo(BankInfo bankInfo) =>
      bankInfo.bankCode.isNotEmpty &&
      bankInfo.accountNumber.isNotEmpty &&
      bankInfo.bankName.isNotEmpty;

  bool hasPersonalDetails() =>
      firstName.isNotNullOrEmpty &&
      lastName.isNotNullOrEmpty &&
      dob != null &&
      citizenshipCode.isNotNullOrEmpty;
}

extension StringNullIfEmpty on String {
  String? get nullIfEmpty => this.isEmpty ? null : this;
}

extension StringNullOrEmptyCheck on String? {
  bool get isNotNullOrEmpty => this?.isNotEmpty ?? false;
}
