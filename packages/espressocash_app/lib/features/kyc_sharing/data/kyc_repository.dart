import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart' hide Order;
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../../accounts/auth_scope.dart';
import '../../accounts/models/ec_wallet.dart';

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

  Future<UserData?> fetchUser() async {
    try {
      return await _getUserData();
    } on Exception {
      return null;
    }
  }

  Future<void> updateUserData({
    Email? email,
    Phone? phone,
    Name? name,
    Document? document,
    BankInfo? bankInfo,
    BirthDate? birthDate,
    Selfie? selfie,
  }) async {
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

  Future<void> initKycVerification({
    required String nameId,
    required String birthDateId,
    required String documentId,
    required String selfieImageId,
  }) async {
    await _kycUserClient.initDocumentValidation(
      nameId: nameId,
      birthDateId: birthDateId,
      documentId: documentId,
      selfieImageId: selfieImageId,
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
