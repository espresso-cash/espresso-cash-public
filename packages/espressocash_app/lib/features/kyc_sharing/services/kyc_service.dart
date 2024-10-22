// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../../accounts/auth_scope.dart';
import '../data/kyc_repository.dart';
import '../models/document_type.dart';
import 'state.dart';

// Hardcoded for now
const validatorAuthPk = 'HHV5joB6D4c2pigVZcQ9RY5suDMvAiHBLLBCFqmWuM4E';
const partnerAuthPk = 'HHV5joB6D4c2pigVZcQ9RY5suDMvAiHBLLBCFqmWuM4E';

@Singleton(scope: authScope)
class KycSharingService extends ValueNotifier<KycState> {
  KycSharingService(
    this._kycRepository,
  ) : super(const KycState());

  final KycRepository _kycRepository;

  @PostConstruct()
  Future<void> init() async {
    final user = await _kycRepository.fetchUser();

    value = KycState(
      user: user,
      kycStatus: user?.kycStatus ?? ValidationStatus.unspecified,
      phoneStatus: user?.phoneStatus ?? ValidationStatus.unspecified,
      emailStatus: user?.emailStatus ?? ValidationStatus.unspecified,
    );
  }

  Future<void> updateBasicInfo({
    String? firstName,
    String? lastName,
    DateTime? dob,
    String? idNumber,
    DocumentType? idType,
    String? countryCode,
  }) async {
    print(idType); //TODO add mapping

    await _kycRepository.updateUserData(
      firstName: firstName,
      lastName: lastName,
      dob: dob,
      idNumber: idNumber,
      idType: IdType.voterId,
      countryCode: countryCode,
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
      bankAccountNumber: bankAccountNumber,
      bankCode: bankCode,
      bankName: bankName ?? '',
    );
  }

  Future<void> updateSelfiePhoto({File? photoSelfie}) =>
      _kycRepository.updateUserData(photoSelfie: photoSelfie);

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
