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
const partnerAuthPk = 'HHV5joB6D4c2pigVZcQ9RY5suDMvAiHBLLBCFqmWuM4E';

@Singleton(scope: authScope)
class KycSharingService {
  KycSharingService(this._xFlowClient, this._ecWallet);

  final XFlowClient _xFlowClient;
  final ECWallet _ecWallet;

  late final KycUserClient _kycUserClient;

  late String _authPublicKey = '';
  late String _rawSecretKey = '';

  KycServiceClient get _validatorClient => _xFlowClient.kycValidatorClient;

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
  }

  Future<void> validate() async {
    final partnerToken =
        await _kycUserClient.generatePartnerToken(partnerAuthPk);

    await _validatorClient.requestKyc(
      KycRequest(
        secretKey: _rawSecretKey,
        partnerToken: partnerToken,
        userAuthPk: _authPublicKey,
        userPublicKey: _ecWallet.publicKey.toString(),
      ),
    );
  }
}
