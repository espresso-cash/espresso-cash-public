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
  late KycUserClient _kycUserClient;

  Future<void>? _clientInitialization;

  Future<void> _init() => _clientInitialization ??= Future(() async {
        try {
          _kycUserClient = _createClient();
          await _kycUserClient.init(
            walletAddress: _ecWallet.publicKey.toString(),
          );
        } on Exception catch (exception) {
          _clientInitialization = null;
          reportError(exception);
        }
      });

  Future<T> _initWrapper<T>(Future<T> Function() operation) async {
    await _init();

    return operation();
  }

  KycUserClient _createClient() => KycUserClient(
        sign: (data) async {
          final signature =
              await _ecWallet.sign([Uint8List.fromList(data.toList())]);

          return signature.first;
        },
      );

  Future<UserData> _getUserData() => _kycUserClient.getUserData(
        userPK: _kycUserClient.authPublicKey,
        secretKey: _kycUserClient.rawSecretKey,
      );

  Future<UserData?> fetchUser() async {
    try {
      return await _initWrapper(_getUserData);
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
    await _initWrapper(
      () => _kycUserClient.setData(
        email: email,
        phone: phone,
        name: name,
        dob: birthDate,
        document: document,
        bankInfo: bankInfo,
        selfie: selfie,
      ),
    );
  }

  Future<void> initEmailVerification({required String emailId}) =>
      _initWrapper(() => _kycUserClient.initEmailValidation(dataId: emailId));

  Future<void> verifyEmail({
    required String code,
    required String dataId,
  }) async {
    await _initWrapper(
      () => _kycUserClient.validateEmail(code: code, dataId: dataId),
    );
  }

  Future<void> initPhoneVerification({required String phoneId}) =>
      _initWrapper(() => _kycUserClient.initPhoneValidation(dataId: phoneId));

  Future<void> verifyPhone({
    required String code,
    required String dataId,
  }) =>
      _initWrapper(
        () => _kycUserClient.validatePhone(code: code, dataId: dataId),
      );

  Future<void> initKycVerification({
    required String nameId,
    required String birthDateId,
    required String documentId,
    required String selfieImageId,
  }) async {
    await _initWrapper(
      () => _kycUserClient.initDocumentValidation(
        nameId: nameId,
        birthDateId: birthDateId,
        documentId: documentId,
        selfieImageId: selfieImageId,
      ),
    );
  }

  Future<String> createOnRampOrder({
    required String cryptoAmount,
    required String cryptoCurrency,
    required String fiatAmount,
    required String fiatCurrency,
    required String partnerPK,
  }) =>
      _initWrapper(
        () => _kycUserClient.createOnRampOrder(
          partnerPK: partnerPK,
          cryptoAmount: cryptoAmount,
          cryptoCurrency: cryptoCurrency,
          fiatAmount: fiatAmount,
          fiatCurrency: fiatCurrency,
        ),
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
      _initWrapper(
        () => _kycUserClient.createOffRampOrder(
          partnerPK: partnerPK,
          cryptoAmount: cryptoAmount,
          cryptoCurrency: cryptoCurrency,
          fiatAmount: fiatAmount,
          fiatCurrency: fiatCurrency,
          bankName: bankName,
          bankAccount: bankAccount,
        ),
      );

  Future<Order> fetchOrder(String orderId) => _initWrapper(
        () => _kycUserClient.getOrder(orderId: OrderId.fromOrderId(orderId)),
      );

  Future<void> grantPartnerAccess(String partnerPk) => _initWrapper(
        () => _kycUserClient.grantPartnerAccess(partnerPk),
      );
}
