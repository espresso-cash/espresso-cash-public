// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';
import 'package:rxdart/rxdart.dart';

import '../../accounts/auth_scope.dart';
import '../../feature_flags/data/feature_flags_manager.dart';
import '../data/kyc_repository.dart';
import '../models/document_type.dart';
import '../utils/kyc_exception.dart';
import '../utils/kyc_utils.dart';

@Singleton(scope: authScope)
class KycSharingService extends ValueNotifier<UserData?> {
  KycSharingService(this._kycRepository, this._featureFlagsManager)
      : super(null);

  final KycRepository _kycRepository;
  final FeatureFlagsManager _featureFlagsManager;

  StreamSubscription<void>? _pollingSubscription;

  final _isInitialized = Completer<void>();
  Future<void> get initialized => _isInitialized.future.then((_) async {
        if (value == null) {
          await fetchUserData();
        }
      });

  @PostConstruct()
  void init() {
    if (!_featureFlagsManager.isBrijEnabled()) return;

    _initializeKyc();
  }

  Future<void> _initializeKyc() async {
    await fetchUserData();
    _isInitialized.complete();

    if (value?.kycStatus == ValidationStatus.pending) {
      _subscribe();
    }
  }

  Future<void> fetchUserData() async {
    final user = await _kycRepository.fetchUser();

    value = user;
    notifyListeners();
  }

  Future<void> fetchStatuses() async {
    final user = await _kycRepository.fetchUser(includeValues: false);

    final emailStatus = user?.email?.status;
    final phoneStatus = user?.phone?.status;
    final nameStatus = user?.name?.status;
    final birthDateStatus = user?.birthDate?.status;
    // TODO(vs): This should be flexible for multiple documents
    final documentStatus = user?.documents?.firstOrNull?.status;
    final selfieStatus = user?.selfie?.status;

    value = value?.copyWith(
      email: emailStatus != null
          ? value?.email?.copyWith(status: emailStatus)
          : value?.email,
      phone: phoneStatus != null
          ? value?.phone?.copyWith(status: phoneStatus)
          : value?.phone,
      name: nameStatus != null
          ? value?.name?.copyWith(status: nameStatus)
          : value?.name,
      birthDate: birthDateStatus != null
          ? value?.birthDate?.copyWith(status: birthDateStatus)
          : value?.birthDate,
      // TODO(vs): This should be flexible for multiple documents
      documents: value?.documents
          ?.map(
            (doc) => documentStatus != null
                ? doc.copyWith(status: documentStatus)
                : doc,
          )
          .toList(),
      bankInfos: value?.bankInfos,
      selfie: selfieStatus != null
          ? value?.selfie?.copyWith(status: selfieStatus)
          : value?.selfie,
    );
    notifyListeners();
  }

  void _subscribe() {
    _unsubscribe();

    _pollingSubscription = Stream<void>.periodic(const Duration(seconds: 15))
        .startWith(null)
        .exhaustMap(
          (_) => fetchStatuses()
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

  Future<void> updatePersonalInfo({
    String? firstName,
    String? lastName,
    DateTime? dob,
    String? citizenshipCode,
  }) async {
    await _kycRepository.grantValidatorAccess();

    await _kycRepository.updateUserData(
      name: Name(
        firstName: firstName ?? '',
        lastName: lastName ?? '',
        id: value?.name?.id ?? '',
      ),
      birthDate: dob?.let(
        (e) => BirthDate(
          value: e,
          id: value?.birthDate?.id ?? '',
        ),
      ),
      citizenship: Citizenship(
        value: citizenshipCode ?? '',
        id: value?.citizenship?.id ?? '',
      ),
    );

    await fetchUserData();
  }

  Future<void> updateDocumentInfo({
    String? idNumber,
    DocumentType? idType,
    DateTime? expirationDate,
    String? countryCode,
  }) async {
    await _kycRepository.grantValidatorAccess();

    await _kycRepository.updateUserData(
      document: Document(
        type: idType?.toIdType() ?? IdType.other,
        number: idNumber ?? '',
        countryCode: countryCode ?? '',
        expirationDate: expirationDate,
        id: value?.documents?.first.id ?? '',
      ),
    );

    await fetchUserData();
  }

  Future<void> updateBankInfo({
    String? id,
    required String bankAccountNumber,
    required String bankCode,
    required String countryCode,
    String? bankName,
  }) async {
    final userBankAccounts = value?.bankInfos;

    final existingAccount = userBankAccounts?.firstWhereOrNull(
      (account) => account.countryCode == countryCode && account.id != id,
    );

    if (existingAccount != null) {
      throw Exception('Bank account already exists for this country');
    }

    await _kycRepository.updateUserData(
      bankInfo: BankInfo(
        accountNumber: bankAccountNumber,
        bankCode: bankCode,
        bankName: bankName ?? '',
        countryCode: countryCode,
        id: id ?? '',
      ),
    );

    await fetchUserData();
  }

  Future<void> startKycVerification({
    required String country,
    required List<String> dataHashes,
  }) async {
    await _kycRepository.startKycVerification(
      country: country,
      dataHashes: dataHashes,
    );
  }

  Future<void> updateSelfiePhoto({File? photoSelfie}) async {
    await _kycRepository.updateUserData(
      selfie: photoSelfie != null
          ? Selfie(
              value: await photoSelfie.readAsBytes(),
              id: value?.selfie?.id ?? '',
            )
          : null,
    );

    await fetchUserData();
  }

  Future<void> initEmailVerification({required String email}) async {
    try {
      await _kycRepository.grantValidatorAccess();

      await _kycRepository.updateUserData(
        email: Email(
          value: email,
          id: value?.email?.id ?? '',
        ),
      );

      await fetchUserData();

      await _kycRepository.initEmailVerification(
        emailId: value?.email?.id ?? '',
      );
    } on Exception catch (exception) {
      throw exception.toKycException();
    }
  }

  Future<void> verifyEmail({required String code}) async {
    try {
      await _kycRepository.verifyEmail(
        code: code,
        dataId: value?.email?.id ?? '',
      );
    } on Exception catch (exception) {
      throw exception.toKycException();
    } finally {
      await fetchStatuses();
    }
  }

  Future<void> initPhoneVerification({required String phone}) async {
    try {
      await _kycRepository.updateUserData(
        phone: Phone(
          value: phone,
          id: value?.phone?.id ?? '',
        ),
      );

      await fetchUserData();

      await _kycRepository.initPhoneVerification(
        phoneId: value?.phone?.id ?? '',
      );
    } on Exception catch (exception) {
      throw exception.toKycException();
    }
  }

  Future<void> verifyPhone({required String code}) async {
    try {
      await _kycRepository.verifyPhone(
        code: code,
        dataId: value?.phone?.id ?? '',
      );
    } on Exception catch (exception) {
      throw exception.toKycException();
    } finally {
      await fetchStatuses();
    }
  }

  Future<bool> hasGrantedAccess(String partnerPk) =>
      _kycRepository.hasGrantedAccess(partnerPk);

  Future<({String termsUrl, String policyUrl})> fetchPartnerTermsAndPolicy(
    String partnerPk,
  ) =>
      _kycRepository.fetchPartnerInfo(partnerPk).then(
            (partner) => (
              termsUrl: partner.termsUrl,
              policyUrl: partner.privacyUrl,
            ),
          );

  @override
  @disposeMethod
  void dispose() {
    _unsubscribe();
    super.dispose();
  }
}
