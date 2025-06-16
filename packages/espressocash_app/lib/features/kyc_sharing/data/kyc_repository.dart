import 'dart:typed_data';

import 'package:brij_client/brij_client.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart' hide Order;

import '../../../utils/errors.dart';
import '../../accounts/auth_scope.dart';
import '../../accounts/models/ec_wallet.dart';
import '../../feature_flags/data/feature_flags_manager.dart';
import '../models/kyc_validation_status.dart';

@Singleton(scope: authScope)
class KycRepository extends ChangeNotifier {
  KycRepository(this._ecWallet, this._featureFlagsManager);

  final ECWallet _ecWallet;
  final FeatureFlagsManager _featureFlagsManager;
  late KycUserClient _kycUserClient;

  Future<void>? _clientInitialization;

  late final _config =
      _featureFlagsManager.isBrijDemoEnabled()
          ? const AppConfig.demo()
          : const AppConfig.production();

  Future<void> _init() =>
      _clientInitialization ??= Future(() async {
        try {
          _kycUserClient = _createClient();
          await _kycUserClient.init(walletAddress: _ecWallet.publicKey.toString());
        } on Exception catch (exception) {
          _clientInitialization = null;
          reportError(exception);
          rethrow;
        }
      });

  Future<T> _initWrapper<T>(Future<T> Function() operation) async {
    await _init();

    return operation();
  }

  KycUserClient _createClient() => KycUserClient(
    config: _config,
    sign: (data) async {
      final signature = await _ecWallet.sign([Uint8List.fromList(data.toList())]);

      return signature.first;
    },
  );

  Future<UserData> _getUserData({required bool includeValues}) => _kycUserClient.getUserData(
    secretKey: _kycUserClient.rawSecretKey,
    includeValues: includeValues,
  );

  Future<UserData?> fetchUser({bool includeValues = true}) async {
    try {
      return await _initWrapper(() => _getUserData(includeValues: includeValues));
    } on Exception catch (exception) {
      reportError(exception);

      return null;
    }
  }

  Future<void> updateUserData({
    Email? email,
    Phone? phone,
    Name? name,
    Citizenship? citizenship,
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
        citizenship: citizenship,
        dob: birthDate,
        document: document,
        bankInfo: bankInfo,
        selfie: selfie,
      ),
    );
  }

  Future<void> initEmailVerification({required String dataHash}) =>
      _initWrapper(() => _kycUserClient.initEmailValidation(dataHash: dataHash));

  Future<void> verifyEmail({required String code, required String dataHash}) async {
    await _initWrapper(() => _kycUserClient.validateEmail(code: code, dataHash: dataHash));
  }

  Future<void> initPhoneVerification({required String dataHash}) =>
      _initWrapper(() => _kycUserClient.initPhoneValidation(dataHash: dataHash));

  Future<void> verifyPhone({required String code, required String dataId}) =>
      _initWrapper(() => _kycUserClient.validatePhone(code: code, dataHash: dataId));

  Future<void> startKycVerification({required String country, required List<String> dataHashes}) =>
      _initWrapper(() => _kycUserClient.startKycRequest(country: country, dataHashes: dataHashes));

  Future<String> createOnRampOrder({
    required double cryptoAmount,
    required String cryptoCurrency,
    required double fiatAmount,
    required String fiatCurrency,
    required String partnerPK,
    required String cryptoWalletAddress,
    required String walletPK,
  }) => _initWrapper(
    () => _kycUserClient.createOnRampOrder(
      partnerPK: partnerPK,
      cryptoAmount: cryptoAmount,
      cryptoCurrency: cryptoCurrency,
      fiatAmount: fiatAmount,
      fiatCurrency: fiatCurrency,
      cryptoWalletAddress: cryptoWalletAddress,
      walletPK: walletPK,
    ),
  );

  Future<String> createOffRampOrder({
    required double cryptoAmount,
    required String cryptoCurrency,
    required double fiatAmount,
    required String fiatCurrency,
    required String cryptoWalletAddress,
    required String partnerPK,
    required String bankName,
    required String bankAccount,
    required String walletPK,
  }) => _initWrapper(
    () => _kycUserClient.createOffRampOrder(
      partnerPK: partnerPK,
      cryptoAmount: cryptoAmount,
      cryptoCurrency: cryptoCurrency,
      cryptoWalletAddress: cryptoWalletAddress,
      fiatAmount: fiatAmount,
      fiatCurrency: fiatCurrency,
      bankName: bankName,
      bankAccount: bankAccount,
      walletPK: walletPK,
    ),
  );

  Future<Order> fetchOrder(String orderId) =>
      _initWrapper(() => _kycUserClient.getOrder(orderId: OrderId.fromOrderId(orderId)));

  Future<void> grantPartnerAccess(String partnerPk) =>
      _initWrapper(() => _kycUserClient.grantPartnerAccess(partnerPk));

  Future<void> grantValidatorAccess() =>
      _initWrapper(() => _kycUserClient.grantPartnerAccess(_config.verifierAuthPk));

  Future<bool> hasGrantedAccess(String partnerPk) =>
      _initWrapper(() => _kycUserClient.hasGrantedAccess(partnerPk));

  Future<PartnerModel> fetchPartnerInfo(String partnerPk) =>
      _initWrapper(() => _kycUserClient.getPartnerInfo(partnerPK: partnerPk));

  Future<KycValidationStatus> fetchKycStatus({required String country}) => _initWrapper(
    () => _kycUserClient.getKycStatus(userPK: _kycUserClient.authPublicKey, country: country),
  ).then((value) => value.toKycValidationStatus());

  Future<KycRequirement> getKycRequirements({required String country}) =>
      _initWrapper(() => _kycUserClient.getKycRequirements(country: country));

  Future<Quote> getQuote({
    required String partnerPK,
    required String walletPK,
    required String fiatCurrency,
    required double cryptoAmount,
    required RampType rampType,
  }) => _initWrapper(
    () => _kycUserClient.getQuote(
      fiatCurrency: fiatCurrency,
      cryptoAmount: cryptoAmount,
      partnerPK: partnerPK,
      walletPK: walletPK,
      rampType: rampType,
    ),
  );
}

const walletAuthPk = '3GEEuaKKs6wrmi8Z8GEafmEC524Tx6wvFHfCp36tTQut';
