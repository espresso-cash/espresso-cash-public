import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:dfunc/dfunc.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../models/kyc_validation_status.dart';

extension UserDataExtensions on UserData {
  String? get firstName => name?.firstName.nullIfEmpty;
  String? get lastName => name?.lastName.nullIfEmpty;
  DateTime? get dob => birthDate?.value;
  String? get citizenshipCode => citizenship?.value.nullIfEmpty;

  String? get getEmail => email?.value.nullIfEmpty;
  String? get getPhone => phone?.value.nullIfEmpty;

  Uint8List? get photo => selfie?.value.let(Uint8List.fromList);

  BankInfo? getBankByCountry(String country) => bankInfos?.firstWhereOrNull(
        (bank) => bank.countryCode == country,
      );

  List<Document>? getDocumentsByCountry(String country) => documents
      ?.where(
        (document) => document.countryCode == country,
      )
      .toList();

  KycValidationStatus get phoneStatus =>
      phone?.status.toKycValidationStatus() ?? KycValidationStatus.unverified;
  KycValidationStatus get emailStatus =>
      email?.status.toKycValidationStatus() ?? KycValidationStatus.unverified;

  bool hasBankInfo(BankInfo bankInfo) =>
      bankInfo.bankCode.isNotEmpty &&
      bankInfo.accountNumber.isNotEmpty &&
      bankInfo.bankName.isNotEmpty;
}

extension StringNullIfEmpty on String {
  String? get nullIfEmpty => this.isEmpty ? null : this;
}
