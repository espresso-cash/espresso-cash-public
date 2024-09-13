import 'dart:io';
import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:kyc_app_client/kyc_app_client.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart' hide KycServiceClient;
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

  late String _authPublicKey = '';
  late String _rawSecretKey = '';
  late String _userPublicKey = '';

  KycServiceClient get _validatorClient => _xFlowClient.kycValidatorClient;
  OtpServiceClient get _otpClient => _xFlowClient.otpServiceClient;
  UserServiceClient get _userClient => _xFlowClient.userServiceClient;

  @PostConstruct()
  Future<void> init() async {
    _kycUserClient = KycUserClient(
      sign: (data) async {
        final signature =
            await _ecWallet.sign([Uint8List.fromList(data.toList())]);

        return signature.first;
      },
      baseUrl: 'https://kyc-backend-oxvpvdtvzq-ew.a.run.app/',
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

      if (selfie != null) {
        //TODO
        print(selfie);

        // final tempDir = await getTemporaryDirectory();
        // final File file = await File('${tempDir.path}/image.png').create();
        // file.writeAsBytesSync(photo);
      }

      return KycUserInfo.fromJson(data);
    } on Exception catch (e) {
      print(e);

      return null;
    }
  }

  Future<void> updateInfo({
    required V1UserData data,
    required File? photo,
  }) async {
    await _kycUserClient.setData(
      data: V1UserData(
        firstName: data.firstName,
        middleName: data.middleName,
        lastName: data.lastName,
        dob: data.dob,
        countryCode: data.countryCode,
        idType: data.idType,
        idNumber: data.idNumber,
        bankAccountNumber: data.bankAccountNumber,
        bankCode: data.bankCode,
      ),
      selfie: photo != null ? await photo.readAsBytes() : null,
      idCard: null,
    );
  }

  Future<void> updateField({
    required OtpType key,
    required String value,
  }) async {
    await _kycUserClient.setData(
      data: V1UserData(
        email: key == OtpType.email ? value : null,
        phone: key == OtpType.phone ? value : null,
      ),
      selfie: null,
      idCard: null,
    );

    switch (key) {
      case OtpType.email:
        await _sendEmailOtp();
      case OtpType.phone:
        await _sendSmsOtp();
      case OtpType.unsupported:
        return;
    }
  }

  Future<bool> verifyField({
    required OtpType identifier,
    required String value,
  }) async {
    final response = await _otpClient.verifyOtp(
      VerifyOtpRequest(
        identifier: identifier,
        otp: value,
        userPk: _authPublicKey,
        secretKey: _rawSecretKey,
      ),
    );

    return response.isValid;
  }

  Future<void> requestKyc() async {
    await _kycUserClient.grantPartnerAccess(validatorAuthPk);
    await _validatorClient.requestKyc(
      KycRequest(
        secretKey: _rawSecretKey,
        userAuthPk: _authPublicKey,
        userPublicKey: _userPublicKey,
      ),
    );
  }

  Future<void> shareDataWithPartner() async {
    await _userClient.sendUserData(
      SendUserDataRequest(
        user: User(
          userPk: _authPublicKey,
          secretKey: _rawSecretKey,
        ),
        partnerPk: partnerAuthPk,
      ),
    );
  }

  Future<void> revokeDataFromPartner() async {
    await _userClient.deleteUserData(
      DeleteUserDataRequest(
        userPk: _authPublicKey,
        partnerPk: partnerAuthPk,
      ),
    );
  }

  Future<void> _sendEmailOtp() async {
    await _otpClient.sendOtpByEmail(
      SendOtpRequest(
        secretKey: _rawSecretKey,
        userPk: _authPublicKey,
      ),
    );
  }

  Future<void> _sendSmsOtp() async {
    await _otpClient.sendOtpBySms(
      SendOtpRequest(
        secretKey: _rawSecretKey,
        userPk: _authPublicKey,
      ),
    );
  }
}
