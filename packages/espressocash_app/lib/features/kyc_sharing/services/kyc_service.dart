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

    // maybe handle it in another way
    await _kycUserClient.grantPartnerAccess(validatorAuthPk);
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
    required KycUserInfo data,
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
        // bankAccountNumber: '', //TODO
        // bankCode: '',
      ),
      selfie: photo != null ? await photo.readAsBytes() : null,
      idCard: null,
    );

    // await validate(); //TODO
  }

  Future<void> updateField({
    required String key,
    required String value,
  }) async {
    await _kycUserClient.setData(
      data: V1UserData(
        email: key == 'email' ? value : null,
        phone: key == 'phone' ? value : null,
      ),
      selfie: null,
      idCard: null,
    );

    switch (key) {
      case 'email':
        await _sendEmailOtp();
      case 'phone':
        await _sendSmsOtp();
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
        // partnerToken: _validatorToken, //TODO
        userAuthPk: _authPublicKey,
        userPublicKey: _userPublicKey,
      ),
    );
  }

  Future<void> sendUserData() async {
    await _userClient.sendUserData(
      SendUserDataRequest(
        user: User(
          userPk: _authPublicKey,
          secretKey: _rawSecretKey,
          // partnerToken: _partnerToken, //TODO
        ),
        partnerPk: partnerAuthPk,
      ),
    );
  }

  // TODO(vsumin): add method to delete user data
  // Future<void> deleteUserData() async {
  //   await _userClient.deleteUserData(
  //     DeleteUserDataRequest(
  //       user: User(
  //         userPk: _authPublicKey,
  //         secretKey: _rawSecretKey,
  //         // partnerToken: _partnerToken,
  //       ),
  //       partnerPk: partnerAuthPk,
  //     ),
  //   );
  //}

  Future<void> _sendEmailOtp() async {
    await _otpClient.sendOtpByEmail(
      SendOtpRequest(
        secretKey: _rawSecretKey,
        // partnerToken: _validatorToken, //TODO
        userPk: _authPublicKey,
      ),
    );
  }

  Future<void> _sendSmsOtp() async {
    await _otpClient.sendOtpBySms(
      SendOtpRequest(
        secretKey: _rawSecretKey,
        // partnerToken: _validatorToken, //TODO
        userPk: _authPublicKey,
      ),
    );
  }
}
