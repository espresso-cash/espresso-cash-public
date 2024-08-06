import 'dart:io';
import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:kyc_app_client/kyc_app_client.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';
import 'package:path_provider/path_provider.dart';

import '../../accounts/auth_scope.dart';
import '../../accounts/models/ec_wallet.dart';
import '../data/client.dart';
import '../models/kyc_model.dart';

// Hardcoded for now
const validatorAuthPk = 'HHV5joB6D4c2pigVZcQ9RY5suDMvAiHBLLBCFqmWuM4E';
const partnerAuthPk = '5PcfzhA3saCwcJjRstKyytMwwxeK1XJt48WGUhZEyecp';

@Singleton(scope: authScope)
class KycSharingService {
  KycSharingService(this._xFlowClient, this._ecWallet);

  final XFlowClient _xFlowClient;
  final ECWallet _ecWallet;

  late final KycUserClient _kycUserClient;

  late String _validatorToken = '';
  late String _partnerToken = '';
  late String _authPublicKey = '';
  late String _rawSecretKey = '';
  late String _userPublicKey = '';

  KycServiceClient get _validatorClient => _xFlowClient.kycValidatorClient;
  OtpServiceClient get _otpClient => _xFlowClient.otpServiceClient;
  PartnerServiceClient get _partnerClient => _xFlowClient.partnerServiceClient;

  @PostConstruct()
  Future<void> init() async {
    _validatorToken = '';
    _partnerToken = '';

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

    _validatorToken =
        await _kycUserClient.generatePartnerToken(validatorAuthPk);
    _partnerToken = await _kycUserClient.generatePartnerToken(partnerAuthPk);
  }

  Future<KycUserInfo?> fetchUser() async {
    try {
      final data = await _kycUserClient.getData(
        keys: [
          DataInfoKeys.firstName,
          DataInfoKeys.middleName,
          DataInfoKeys.lastName,
          DataInfoKeys.dateOfBirth,
          DataInfoKeys.countryCode,
          DataInfoKeys.idType,
          DataInfoKeys.idNumber,
        ],
        userPK: _authPublicKey,
        secretKey: _rawSecretKey,
      );

      final photo = await _kycUserClient.download(
        key: DataFileKeys.photo,
        userPK: _authPublicKey,
        secretKey: _rawSecretKey,
      );

      final tempDir = await getTemporaryDirectory();
      final File file = await File('${tempDir.path}/image.png').create();
      file.writeAsBytesSync(photo);

      return KycUserInfo.fromJson(data).copyWith(photo: file);
    } on Exception {
      return null;
    }
  }

  Future<void> updateInfo({
    required KycUserInfo data,
    required File photo,
  }) async {
    await _kycUserClient.setData(data: data.toKycModel());
    await _kycUserClient.upload(
      file: photo.readAsBytesSync(),
      key: DataFileKeys.photo,
    );

    await validate();
  }

  Future<void> updateField({
    required DataInfoKeys key,
    required String value,
  }) async {
    await _kycUserClient.setData(data: {key: value});

    switch (key) {
      case DataInfoKeys.email:
        await _sendEmailOtp();
      case DataInfoKeys.phone:
        await _sendSmsOtp();
      // ignore: avoid-wildcard-cases-with-enums, check if needed
      case _:
        return;
    }
  }

  Future<bool> verifyField({
    required String identifier,
    required String value,
  }) async {
    final response = await _otpClient.verifyOtp(
      VerifyOtpRequest(
        identifier: identifier,
        otp: value,
        userPk: _authPublicKey,
      ),
    );

    return response.isValid;
  }

  Future<void> validate() async {
    await _validatorClient.requestKyc(
      KycRequest(
        secretKey: _rawSecretKey,
        partnerToken: _validatorToken,
        userAuthPk: _authPublicKey,
        userPublicKey: _userPublicKey,
      ),
    );
  }

  Future<void> sendUserData() async {
    await _partnerClient.sendUserData(
      SendUserDataRequest(
        user: User(
          userPk: _authPublicKey,
          secretKey: _rawSecretKey,
          partnerToken: _partnerToken,
        ),
        partnerPk: partnerAuthPk,
      ),
    );
  }

  Future<void> _sendEmailOtp() async {
    await _otpClient.sendOtpByEmail(
      SendOtpRequest(
        secretKey: _rawSecretKey,
        partnerToken: _validatorToken,
        userPk: _authPublicKey,
      ),
    );
  }

  Future<void> _sendSmsOtp() async {
    await _otpClient.sendOtpBySms(
      SendOtpRequest(
        secretKey: _rawSecretKey,
        partnerToken: _validatorToken,
        userPk: _authPublicKey,
      ),
    );
  }
}
