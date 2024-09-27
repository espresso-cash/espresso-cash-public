// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:kyc_app_client/kyc_app_client.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart' hide KycServiceClient;
import 'package:shared_preferences/shared_preferences.dart';

import '../../accounts/auth_scope.dart';
import '../data/kyc_repository.dart';
import 'state.dart';

// Hardcoded for now
const validatorAuthPk = '5PcfzhA3saCwcJjRstKyytMwwxeK1XJt48WGUhZEyecp';
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

    await _kycRepository.shareDataWithPartner();
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

  Future<void> updateAndSendCode({
    required OtpType key,
    required String value,
  }) async {
    await _kycRepository.updateVerificationField(key: key, value: value);
    await _kycRepository.sendVerificationCode(key: key);
  }

  Future<bool> verifyAndValidateField({
    required OtpType identifier,
    required String value,
  }) async {
    final result = await _kycRepository.verifyField(
      identifier: identifier,
      value: value,
    );

    if (identifier == OtpType.email) {
      hasValidatedEmail(result);
    }

    if (identifier == OtpType.phone) {
      hasValidatedPhone(result);
    }

    return result;
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

  Future<String> createOrder({
    required String cryptoAmount,
    required String cryptoCurrency,
    required String partnerPK,
  }) =>
      _kycRepository.createOrder(
        cryptoAmount: cryptoAmount,
        cryptoCurrency: cryptoCurrency,
        partnerPK: partnerPK,
      );

  Future<void> requestKyc() => _kycRepository.requestKyc();

  Future<void> shareDataWithPartner() => _kycRepository.shareDataWithPartner();

  // Future<void> revokeDataFromPartner() =>
  //     _kycRepository.revokeDataFromPartner();

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
