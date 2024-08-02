import 'dart:io';
import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../../../gen/kyc.pbgrpc.dart';
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

  late String _partnerToken = '';
  late String _authPublicKey = '';
  late String _rawSecretKey = '';

  KycServiceClient get _validatorClient => _xFlowClient.kycValidatorClient;

  @PostConstruct()
  Future<void> init() async {
    _partnerToken = '';

    _kycUserClient = KycUserClient(
      sign: (data) async {
        final signature =
            await _ecWallet.sign([Uint8List.fromList(data.toList())]);

        return signature.first;
      },
    );

    await _kycUserClient.init();
    await _kycUserClient.initStorage(
      walletAddress: _ecWallet.publicKey.toString(),
    );

    _rawSecretKey = _kycUserClient.rawSecretKey;
    _authPublicKey = _kycUserClient.authPublicKey;

    _partnerToken = await _kycUserClient.generatePartnerToken(partnerAuthPk);
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

  Future<void> validate() async {
    await _validatorClient.requestKyc(
      KycRequest(
        secretKey: _rawSecretKey,
        partnerToken: _partnerToken,
        userPk: _authPublicKey,
      ),
    );
  }
}
