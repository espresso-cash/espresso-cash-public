import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart' hide KycServiceClient;

import '../../accounts/auth_scope.dart';
import '../../accounts/models/ec_wallet.dart';
import '../models/kyc_model.dart';

// Hardcoded for now
const validatorAuthPk = '5PcfzhA3saCwcJjRstKyytMwwxeK1XJt48WGUhZEyecp';
const partnerAuthPk = 'HHV5joB6D4c2pigVZcQ9RY5suDMvAiHBLLBCFqmWuM4E';

@Singleton(scope: authScope)
class KycRepository extends ChangeNotifier {
  KycRepository(
    this._ecWallet,
  );
  final ECWallet _ecWallet;

  late final KycUserClient _kycUserClient;

  late String _authPublicKey = '';
  late String _rawSecretKey = '';
  late String _userPublicKey = '';

  @PostConstruct()
  Future<void> init() async {
    _kycUserClient = KycUserClient(
      sign: (data) async {
        final signature =
            await _ecWallet.sign([Uint8List.fromList(data.toList())]);

        return signature.first;
      },
    );

    await _kycUserClient.init(
      walletAddress: _ecWallet.publicKey.toString(),
    );

    _rawSecretKey = _kycUserClient.rawSecretKey;
    _authPublicKey = _kycUserClient.authPublicKey;
    _userPublicKey = _ecWallet.publicKey.toString();
  }

  Future<KycUserInfo?> fetchUser() async {
    try {
      final data = await _kycUserClient.getData(
        userPK: _authPublicKey,
        secretKey: _rawSecretKey,
      );

      final selfie = data['photoSelfie'];
      final id = data['photoIdCard'];

      return KycUserInfo.fromJson(data).copyWith(
        photoSelfie: (selfie is Uint8List) ? selfie : null,
        photoIdCard: (id is Uint8List) ? id : null,
      );
    } on Exception {
      //ignore, user not registered

      return null;
    }
  }

  Future<void> updateInfo({
    V1UserData? data,
    File? photoSelfie,
    File? photoId,
  }) async {
    await _kycUserClient.setData(
      data: data != null
          ? V1UserData(
              firstName: data.firstName,
              middleName: data.middleName,
              lastName: data.lastName,
              dob: data.dob,
              countryCode: data.countryCode,
              idType: data.idType,
              idNumber: data.idNumber,
              bankAccountNumber: data.bankAccountNumber,
              bankCode: data.bankCode,
            )
          : const V1UserData(),
      selfie: photoSelfie != null ? await photoSelfie.readAsBytes() : null,
      idCard: photoId != null ? await photoId.readAsBytes() : null,
    );
  }

  Future<void> initEmailVerification(String email) async {
    await _kycUserClient.setData(
      data: V1UserData(
        email: email,
      ),
      selfie: null,
      idCard: null,
    );
    await _kycUserClient.initEmailValidation();
  }

  Future<void> verifyEmail(String code) async {
    await _kycUserClient.validateEmail(code);
  }

  Future<void> initPhoneVerification(String phone) async {
    await _kycUserClient.setData(
      data: V1UserData(
        phone: phone,
      ),
      selfie: null,
      idCard: null,
    );
    await _kycUserClient.initPhoneValidation();
  }

  Future<void> verifyPhone(String code) async {
    await _kycUserClient.validatePhone(code);
  }

  Future<void> initDocumentVerification() async {
    await _kycUserClient.grantPartnerAccess(validatorAuthPk);
    await _kycUserClient.initDocumentValidation();
  }

  Future<String> createOrder({
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

  Future<V1GetOrderResponse> fetchOrder(String orderId) =>
      _kycUserClient.getOrder(orderId);

  Future<void> shareDataWithPartner(String partnerPk) =>
      _kycUserClient.grantPartnerAccess(partnerPk);
}
