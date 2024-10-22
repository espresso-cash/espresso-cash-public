// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:async';
import 'dart:io';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../../accounts/auth_scope.dart';
import '../data/kyc_repository.dart';
import '../models/document_type.dart';

// Hardcoded for now
const validatorAuthPk = 'HHV5joB6D4c2pigVZcQ9RY5suDMvAiHBLLBCFqmWuM4E';
const partnerAuthPk = 'HHV5joB6D4c2pigVZcQ9RY5suDMvAiHBLLBCFqmWuM4E';

@Singleton(scope: authScope)
class KycSharingService extends ValueNotifier<UserData?> {
  KycSharingService(this._kycRepository) : super(const UserData());

  final KycRepository _kycRepository;

  Timer? _fetchTimer;

  @PostConstruct()
  Future<void> init() async {
    await fetchUserData();
  }

  Future<void> fetchUserData() async {
    final user = await _kycRepository.fetchUser();

    value = user;
    notifyListeners();
  }

  void subscribeToUserData() {
    unsubscribeFromUserData();

    fetchUserData();

    _fetchTimer = Timer.periodic(const Duration(seconds: 10), (_) async {
      await fetchUserData();
      // Fake status update
      // value = value?.copyWith(
      //   name: [value!.name!.first.copyWith(status: ValidationStatus.approved)],
      // );
      // notifyListeners();
    });
  }

  void unsubscribeFromUserData() {
    _fetchTimer?.cancel();
    _fetchTimer = null;
  }

  Future<void> updateBasicInfo({
    String? firstName,
    String? lastName,
    DateTime? dob,
    String? idNumber,
    DocumentType? idType,
    String? countryCode,
  }) async {
    await _kycRepository.updateUserData(
      name: Name(
        firstName: firstName ?? '',
        lastName: lastName ?? '',
        id: value?.name?.first.id ?? '',
      ),
      birthDate: dob?.let(
        (e) => BirthDate(
          value: e,
          id: value?.birthDate?.first.id ?? '',
        ),
      ),
      document: Document(
        type: idType?.toIdType() ?? IdType.other,
        number: idNumber ?? '',
        countryCode: countryCode ?? '',
        id: value?.document?.first.id ?? '',
      ),
    );

    await _kycRepository.grantPartnerAccess(partnerAuthPk);
    await _kycRepository.grantPartnerAccess(validatorAuthPk);
  }

  Future<void> updateBankInfo({
    required String bankAccountNumber,
    required String bankCode,
    String? bankName,
  }) async {
    await _kycRepository.updateUserData(
      bankInfo: BankInfo(
        accountNumber: bankAccountNumber,
        bankCode: bankCode,
        bankName: bankName ?? '',
        id: value?.bankInfo?.first.id ?? '',
      ),
    );
  }

  Future<void> initDocumentValidation() => _kycRepository.initKycVerification(
        nameId: value?.name?.first.id ?? '',
        birthDateId: value?.birthDate?.first.id ?? '',
        documentId: value?.document?.first.id ?? '',
        selfieImageId: value?.selfie?.first.id ?? '',
      );

  Future<void> updateSelfiePhoto({File? photoSelfie}) async =>
      _kycRepository.updateUserData(
        selfie: photoSelfie != null
            ? Selfie(
                value: await photoSelfie.readAsBytes(),
                id: value?.selfie?.first.id ?? '',
              )
            : null,
      );

  Future<void> initEmailVerification({required String email}) =>
      _kycRepository.initEmailVerification(email: email);

  Future<void> verifyEmail({required String code}) async {
    final dataId = await _kycRepository.getEmailDataId();
    await _kycRepository.verifyEmail(code: code, dataId: dataId ?? '');
  }

  Future<void> initPhoneVerification({required String phone}) =>
      _kycRepository.initPhoneVerification(phone: phone);

  Future<void> verifyPhone({required String code}) async {
    final dataId = await _kycRepository.getPhoneDataId();
    await _kycRepository.verifyPhone(code: code, dataId: dataId ?? '');
  }

  Future<void> shareDataWithPartner(String partnerPk) =>
      _kycRepository.grantPartnerAccess(partnerPk);
}
