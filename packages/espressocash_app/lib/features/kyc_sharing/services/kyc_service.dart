// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart' hide KycServiceClient;
import 'package:shared_preferences/shared_preferences.dart';

import '../../accounts/auth_scope.dart';
import '../data/kyc_repository.dart';
import 'state.dart';

// Hardcoded for now
const validatorAuthPk = 'HHV5joB6D4c2pigVZcQ9RY5suDMvAiHBLLBCFqmWuM4E';
const partnerAuthPk = 'HHV5joB6D4c2pigVZcQ9RY5suDMvAiHBLLBCFqmWuM4E';

@Singleton(scope: authScope)
class KycSharingService extends ValueNotifier<KycState> {
  KycSharingService(
    this._kycRepository,
    this._storage,
  ) : super(const KycState());

  final KycRepository _kycRepository;
  final SharedPreferences _storage;

  @PostConstruct()
  Future<void> init() async {
    final user = await _kycRepository.fetchUser();

    value = KycState(
      user: user,
      hasPassedKyc: _storage.getBool(_kycVerifiedKey) ?? false,
      hasValidatedEmail: _storage.getBool(_emailValidatedKey) ?? false,
      hasValidatedPhone: _storage.getBool(_phoneValidatedKey) ?? false,
    );
  }

  Future<void> updateUserInfo({
    required String firstName,
    required String middleName,
    required String lastName,
    required String dob,
    required String countryCode,
    required String idType,
    required String idNumber,
    required File? selfiePhoto,
  }) async {
    await _kycRepository.updateInfo(
      data: V1UserData(
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        dob: dob,
        countryCode: countryCode,
        idType: idType,
        idNumber: idNumber,
      ),
      photoSelfie: selfiePhoto,
    );

    await _kycRepository.grantPartnerAccess(partnerAuthPk);
    await _kycRepository.grantPartnerAccess(validatorAuthPk);
  }

  Future<void> updateBankInfo({
    required String bankAccountNumber,
    required String bankCode,
  }) async {
    await _kycRepository.updateInfo(
      data: V1UserData(
        bankAccountNumber: bankAccountNumber,
        bankCode: bankCode,
      ),
    );

    hasPassedKyc(true);
  }

  Future<void> updateUserEmailPhone({
    String? email,
    String? phone,
  }) =>
      _kycRepository.updateInfo(
        data: V1UserData(
          email: email,
          phone: phone,
        ),
      );

  Future<void> updatePhoto({
    File? photoSelfie,
    File? photoId,
  }) =>
      _kycRepository.updateInfo(
        photoSelfie: photoSelfie,
        photoId: photoId,
      );

  Future<void> initEmailVerification({required String email}) async {
    await _kycRepository.initEmailVerification(email: email);
  }

  Future<void> initPhoneVerification({required String phone}) async {
    await _kycRepository.initPhoneVerification(phone: phone);
  }

  Future<void> verifyEmail({required String code}) async {
    await _kycRepository.verifyEmail(code: code);
    hasValidatedEmail(true);
  }

  Future<void> verifyPhone({required String code}) async {
    await _kycRepository.verifyPhone(code: code);
    hasValidatedPhone(true);
  }

  void hasValidatedEmail(bool result) {
    _storage.setBool(_emailValidatedKey, result);
    value = value.copyWith(hasValidatedEmail: result);
  }

  void hasValidatedPhone(bool result) {
    _storage.setBool(_phoneValidatedKey, result);
    value = value.copyWith(hasValidatedPhone: result);
  }

  void hasPassedKyc(bool result) {
    _storage.setBool(_kycVerifiedKey, result);
    value = value.copyWith(hasPassedKyc: result);
  }

  // Future<void> requestKyc() => _kycRepository.initDocumentVerification(); //TODO

  Future<void> shareDataWithPartner(String partnerPk) =>
      _kycRepository.grantPartnerAccess(partnerPk);

  @override
  @disposeMethod
  void dispose() {
    _storage
      ..remove(_emailValidatedKey)
      ..remove(_phoneValidatedKey)
      ..remove(_kycVerifiedKey);

    super.dispose();
  }
}

const _emailValidatedKey = 'kycEmailValidated';
const _phoneValidatedKey = 'kycPhoneValidated';
const _kycVerifiedKey = 'kycVerified';
