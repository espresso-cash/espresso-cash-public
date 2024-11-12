// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:async';
import 'dart:io';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';
import 'package:rxdart/rxdart.dart';

import '../../../di.dart';
import '../../accounts/auth_scope.dart';
import '../../feature_flags/services/feature_flags_manager.dart';
import '../data/kyc_repository.dart';
import '../models/document_type.dart';

// Hardcoded for now
const partnerAuthPk = 'J4Bi8wQnvcX4kLyiA7xemJ7t4bikDncgWUZAscvymGPq';

@Singleton(scope: authScope)
class KycSharingService extends ValueNotifier<UserData?> {
  KycSharingService(this._kycRepository) : super(const UserData());

  final KycRepository _kycRepository;

  StreamSubscription<void>? _pollingSubscription;

  @PostConstruct()
  Future<void> init() async {
    if (!sl<FeatureFlagsManager>().isXflowEnabled()) return;

    await fetchUserData();
  }

  Future<void> fetchUserData() async {
    final user = await _kycRepository.fetchUser();

    value = user;
    notifyListeners();
  }

  void subscribe() {
    unsubscribe();

    _pollingSubscription = Stream<void>.periodic(const Duration(seconds: 10))
        .startWith(null)
        .exhaustMap(
          (_) => fetchUserData()
              .timeout(
                const Duration(seconds: 8),
                onTimeout: () => null,
              )
              .asStream()
              .onErrorReturn(null),
        )
        .listen((_) {});
  }

  void unsubscribe() {
    _pollingSubscription?.cancel();
    _pollingSubscription = null;
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

    // TODO(dev): move selecting of partner, should not be here
    await _kycRepository.grantPartnerAccess(partnerAuthPk);

    await fetchUserData();
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

    await fetchUserData();
  }

  Future<void> initDocumentValidation() async {
    await _kycRepository.initKycVerification(
      nameId: value?.name?.first.id ?? '',
      birthDateId: value?.birthDate?.first.id ?? '',
      documentId: value?.document?.first.id ?? '',
      selfieImageId: value?.selfie?.first.id ?? '',
    );

    await fetchUserData();
  }

  Future<void> updateSelfiePhoto({File? photoSelfie}) async {
    await _kycRepository.updateUserData(
      selfie: photoSelfie != null
          ? Selfie(
              value: await photoSelfie.readAsBytes(),
              id: value?.selfie?.first.id ?? '',
            )
          : null,
    );

    await fetchUserData();
  }

  Future<void> initEmailVerification({required String email}) async {
    await _kycRepository.grantPartnerAccess(validatorAuthPk);

    await _kycRepository.updateUserData(
      email: Email(
        value: email,
        id: value?.email?.first.id ?? '',
      ),
    );

    await fetchUserData();

    await _kycRepository.initEmailVerification(
      emailId: value?.email?.first.id ?? '',
    );
  }

  Future<void> verifyEmail({required String code}) async {
    await _kycRepository.verifyEmail(
      code: code,
      dataId: value?.email?.first.id ?? '',
    );

    await fetchUserData();
  }

  Future<void> initPhoneVerification({required String phone}) async {
    await _kycRepository.updateUserData(
      phone: Phone(
        value: phone,
        id: value?.phone?.first.id ?? '',
      ),
    );

    await fetchUserData();

    // TODO(vsumin): Currently do not work on test environment
    // await _kycRepository.initPhoneVerification(
    //   phoneId: value?.phone?.first.id ?? '',
    // );
  }

  Future<void> verifyPhone({required String code}) async {
    await _kycRepository.verifyPhone(
      code: code,
      dataId: value?.phone?.first.id ?? '',
    );

    await fetchUserData();
  }

  @override
  @disposeMethod
  void dispose() {
    unsubscribe();
    super.dispose();
  }
}

const validatorAuthPk = 'HHV5joB6D4c2pigVZcQ9RY5suDMvAiHBLLBCFqmWuM4E';
