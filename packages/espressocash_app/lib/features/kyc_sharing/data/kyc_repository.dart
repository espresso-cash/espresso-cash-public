import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart' hide Order;
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../../../utils/errors.dart';
import '../../accounts/auth_scope.dart';
import '../../accounts/models/ec_wallet.dart';

@Singleton(scope: authScope)
class KycRepository extends ChangeNotifier {
  KycRepository(this._ecWallet);

  final ECWallet _ecWallet;

  late final KycUserClient _kycUserClient = KycUserClient(
    sign: (data) async {
      final signature =
          await _ecWallet.sign([Uint8List.fromList(data.toList())]);

      return signature.first;
    },
  );

  Future<void>? _clientInitialization;

  Future<void> init() => _clientInitialization ??= Future(() async {
        while (true) {
          try {
            await _kycUserClient.init(
              walletAddress: _ecWallet.publicKey.toString(),
            );
            break;
          } on Exception catch (exception) {
            reportError(exception);

            await Future<void>.delayed(const Duration(seconds: 15));
          }
        }
      });

  Future<UserData> _getUserData() => _kycUserClient.getUserData(
        userPK: _kycUserClient.authPublicKey,
        secretKey: _kycUserClient.rawSecretKey,
      );

  Future<UserData?> fetchUser() async {
    try {
      await _clientInitialization;

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

  Future<void> initEmailVerification({required String emailId}) =>
      _kycUserClient.initEmailValidation(dataId: emailId);

  Future<void> verifyEmail({
    required String code,
    required String dataId,
  }) async {
    await _kycUserClient.validateEmail(code: code, dataId: dataId);
  }

  Future<void> initPhoneVerification({required String phoneId}) =>
      _kycUserClient.initPhoneValidation(dataId: phoneId);

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
