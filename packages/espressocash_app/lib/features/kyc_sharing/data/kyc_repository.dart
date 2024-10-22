import 'dart:io';
import 'dart:typed_data';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart' hide Order;
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../../accounts/auth_scope.dart';
import '../../accounts/models/ec_wallet.dart';
import '../models/kyc_user_info.dart';

@Singleton(scope: authScope)
class KycRepository extends ChangeNotifier {
  KycRepository(this._ecWallet);

  final ECWallet _ecWallet;

  late final KycUserClient _kycUserClient;

  late String _authPublicKey = '';
  late String _rawSecretKey = '';

  @PostConstruct()
  Future<void> init() async {
    _kycUserClient = KycUserClient(
      sign: (data) async {
        final signature =
            await _ecWallet.sign([Uint8List.fromList(data.toList())]);

        return signature.first;
      },
    );

    await _kycUserClient.init(walletAddress: _ecWallet.publicKey.toString());

    _rawSecretKey = _kycUserClient.rawSecretKey;
    _authPublicKey = _kycUserClient.authPublicKey;
  }

  Future<UserData> _getUserData() => _kycUserClient.getUserData(
        userPK: _authPublicKey,
        secretKey: _rawSecretKey,
      );

  Future<KycUserInfo?> fetchUser() async {
    try {
      final data = await _getUserData();

      final name = data.name?.first;
      final dob = data.birthDate?.first;
      final email = data.email?.first;
      final phone = data.phone?.first;
      final selfie = data.selfie?.first;
      final document = data.document?.first;
      final bank = data.bankInfo?.first;

      return KycUserInfo(
        firstName: name?.firstName ?? '',
        lastName: name?.lastName ?? '',
        dob: dob?.value ?? DateTime.now(),
        idType: document?.type.name ?? '',
        idNumber: document?.number ?? '',
        countryCode: document?.countryCode ?? '',
        email: email?.value ?? '',
        phone: phone?.value ?? '',
        photoSelfie: selfie?.value.let(Uint8List.fromList),
        bankAccountNumber: bank?.accountNumber ?? '',
        bankCode: bank?.bankCode ?? '',
        bankName: bank?.bankName ?? '',
        kycStatus: name?.status ?? ValidationStatus.unspecified,
        phoneStatus: phone?.status ?? ValidationStatus.unspecified,
        emailStatus: email?.status ?? ValidationStatus.unspecified,
      );
    } on Exception {
      return null;
    }
  }

  // TODOrefactor this, should have ID to create or update
  Future<void> updateUserData({
    String? firstName,
    String? lastName,
    DateTime? dob,
    String? idNumber,
    IdType? idType,
    String? countryCode,
    String? bankAccountNumber,
    String? bankCode,
    String? bankName,
    File? photoSelfie,
  }) async {
    Email? email;
    Phone? phone;
    Name? name;
    Document? document;
    BankInfo? bankInfo;
    BirthDate? birthDate;
    Selfie? selfie;

    if (firstName != null && lastName != null) {
      name = Name(
        firstName: firstName,
        lastName: lastName,
      );
    }

    if (dob != null) {
      birthDate = BirthDate(value: dob);
    }

    if (idNumber != null && countryCode != null && idType != null) {
      document = Document(
        type: idType,
        number: idNumber,
        countryCode: countryCode,
      );
    }

    if (bankAccountNumber != null && bankCode != null || bankName != null) {
      bankInfo = BankInfo(
        accountNumber: bankAccountNumber ?? '',
        bankCode: bankCode ?? '',
        bankName: bankName ?? '',
      );
    }

    if (photoSelfie != null) {
      selfie = Selfie(value: await photoSelfie.readAsBytes());
    }

    await _kycUserClient.setData(
      email: email,
      phone: phone,
      name: name,
      dob: birthDate,
      document: document,
      bankInfo: bankInfo,
      selfie: selfie,
    );
  }

  Future<String?> getEmailDataId() async {
    final data = await _getUserData();

    return data.email?.first.id;
  }

  Future<String?> getPhoneDataId() async {
    final data = await _getUserData();

    return data.phone?.first.id;
  }

  Future<void> initEmailVerification({required String email}) async {
    await _kycUserClient.setData(email: Email(value: email));
    final dataId = await getEmailDataId();

    await _kycUserClient.initEmailValidation(dataId: dataId ?? '');
  }

  Future<void> verifyEmail({
    required String code,
    required String dataId,
  }) async {
    await _kycUserClient.validateEmail(code: code, dataId: dataId);
  }

  Future<void> initPhoneVerification({required String phone}) async {
    await _kycUserClient.setData(phone: Phone(value: phone));
    final dataId = await getPhoneDataId();

    await _kycUserClient.initPhoneValidation(dataId: dataId ?? '');
  }

  Future<void> verifyPhone({
    required String code,
    required String dataId,
  }) =>
      _kycUserClient.validatePhone(code: code, dataId: dataId);

  Future<void> initKycVerification() async {
    final data = await _getUserData();

    final nameId = data.name?.first.id;
    final birthDateId = data.birthDate?.first.id;
    final documentId = data.document?.first.id;
    final selfieImageId = data.selfie?.first.id;

    await _kycUserClient.initDocumentValidation(
      nameId: nameId ?? '',
      birthDateId: birthDateId ?? '',
      documentId: documentId ?? '',
      selfieImageId: selfieImageId ?? '',
    );
  }

  Future<String> createOnRampOrder({
    required String cryptoAmount,
    required String cryptoCurrency,
    required String fiatAmount,
    required String fiatCurrency,
    required String partnerPK,
  }) =>
      _kycUserClient.createOnRampOrder(
        partnerPK: partnerPK,
        cryptoAmount: cryptoAmount,
        cryptoCurrency: cryptoCurrency,
        fiatAmount: fiatAmount,
        fiatCurrency: fiatCurrency,
      );

  Future<String> createOffRampOrder({
    required String cryptoAmount,
    required String cryptoCurrency,
    required String fiatAmount,
    required String fiatCurrency,
    required String partnerPK,
    required String bankName,
    required String bankAccount,
  }) =>
      _kycUserClient.createOffRampOrder(
        partnerPK: partnerPK,
        cryptoAmount: cryptoAmount,
        cryptoCurrency: cryptoCurrency,
        fiatAmount: fiatAmount,
        fiatCurrency: fiatCurrency,
        bankName: bankName,
        bankAccount: bankAccount,
      );

  Future<Order> fetchOrder(String orderId) =>
      _kycUserClient.getOrder(orderId: OrderId.fromOrderId(orderId));

  Future<void> grantPartnerAccess(String partnerPk) =>
      _kycUserClient.grantPartnerAccess(partnerPk);
}
