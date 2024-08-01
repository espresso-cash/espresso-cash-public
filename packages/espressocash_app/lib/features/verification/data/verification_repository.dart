import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../../accounts/auth_scope.dart';
import '../../accounts/models/ec_wallet.dart';

const partnerAuthPk = 'HHV5joB6D4c2pigVZcQ9RY5suDMvAiHBLLBCFqmWuM4E';

@Singleton(scope: authScope)
class VerificationRepository extends ChangeNotifier {
  VerificationRepository(this._account);

  final ECWallet _account;

  String get authPublicKey => _authPublicKey;
  String get rawSecretKey => _rawSecretKey;
  String get partnerToken => _partnerToken;
  PartnerModel? get partnerInfo => _partnerInfo;
  String? get email => _email;
  String? get phoneNumber => _phoneNumber;

  late String _authPublicKey = '';
  String _partnerToken = '';
  late String _rawSecretKey = '';

  PartnerModel? _partnerInfo;
  String? _email;
  String? _phoneNumber;

  late KycUserClient _client;

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    _partnerToken = '';

    _client = KycUserClient(
      sign: (data) async {
        final payloads = data.map((int value) => Uint8List.fromList([value]));

        return _account.sign(payloads).then((value) => value.first);
      },
    );

    await _client.init();
    await _client.initStorage(walletAddress: _account.publicKey.toString());

    _rawSecretKey = _client.rawSecretKey;
    _authPublicKey = _client.authPublicKey;

    notifyListeners();
  }

  Future<void> generatePartnerToken(String partnerPK) async {
    _partnerToken = await _client.generatePartnerToken(partnerPK);

    notifyListeners();
  }

  // Future<void> updateInfo({
  //   required KycUserInfo data,
  //   required File photo,
  // }) async {
  //   await _client.setData(data: data.toMap());
  //   await _client.upload(
  //     file: photo.readAsBytesSync(),
  //     key: DataFileKeys.photo,
  //   );
  // }

  Future<void> updateEmail(String value) async {
    _email = value;
    await _client.setData(data: {DataInfoKeys.email: value});
    notifyListeners();
  }

  Future<void> updateNumber(String value) async {
    _phoneNumber = value;
    await _client.setData(data: {DataInfoKeys.phone: value});
    notifyListeners();
  }
}
