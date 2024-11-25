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
import '../utils/kyc_exception.dart';
import '../utils/kyc_utils.dart';

@Singleton(scope: authScope)
class KycSharingService extends ValueNotifier<UserData?> {
  KycSharingService(this._kycRepository) : super(null);

  final KycRepository _kycRepository;

  StreamSubscription<void>? _pollingSubscription;

  @PostConstruct()
  void init() {
    if (!sl<FeatureFlagsManager>().isBrijEnabled()) return;

    _initializeKyc();
  }

  Future<void> _initializeKyc() async {
    await fetchUserData();

    if (value?.kycStatus == ValidationStatus.pending) {
      _subscribe();
    }
  }

  Future<void> fetchUserData() async {
    final user = await _kycRepository.fetchUser();

    value = user;
    notifyListeners();
  }

  void _subscribe() {
    _unsubscribe();

    _pollingSubscription = Stream<void>.periodic(const Duration(seconds: 15))
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
        .takeWhile((_) => value?.kycStatus == ValidationStatus.pending)
        .listen((_) {});
  }

  void _unsubscribe() {
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
    await _kycRepository.grantPartnerAccess(verifierAuthPk);

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
    _subscribe();
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
    try {
      await _kycRepository.grantPartnerAccess(verifierAuthPk);

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
    } on Exception catch (exception) {
      throw exception.toKycException();
    }
  }

  Future<void> verifyEmail({required String code}) async {
    try {
      await _kycRepository.verifyEmail(
        code: code,
        dataId: value?.email?.first.id ?? '',
      );
    } on Exception catch (exception) {
      throw exception.toKycException();
    } finally {
      await fetchUserData();
    }
  }

  Future<void> initPhoneVerification({required String phone}) async {
    try {
      await _kycRepository.updateUserData(
        phone: Phone(
          value: phone,
          id: value?.phone?.first.id ?? '',
        ),
      );

      await fetchUserData();

      await _kycRepository.initPhoneVerification(
        phoneId: value?.phone?.first.id ?? '',
      );
    } on Exception catch (exception) {
      throw exception.toKycException();
    }
  }

  Future<void> verifyPhone({required String code}) async {
    try {
      await _kycRepository.verifyPhone(
        code: code,
        dataId: value?.phone?.first.id ?? '',
      );
    } on Exception catch (exception) {
      throw exception.toKycException();
    } finally {
      await fetchUserData();
    }
  }

  @override
  @disposeMethod
  void dispose() {
    _unsubscribe();
    super.dispose();
  }
}

const verifierAuthPk = '88tFG8dt9ZacDZb7QP5yiDQeA7sVXvr7XCwZEQSsnCkJ';
