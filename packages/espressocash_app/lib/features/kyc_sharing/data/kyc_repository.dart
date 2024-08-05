import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../../accounts/auth_scope.dart';
import '../../accounts/models/ec_wallet.dart';

@Singleton(scope: authScope)
class KycRepository extends ChangeNotifier {
  KycRepository(this._ecWallet);

  final ECWallet _ecWallet;

  late final KycPartnerClient _client;

  @PostConstruct()
  void init() {
    // // should we use partner client here, or instead set result to shared preferences?
    // _client = KycPartnerClient(authKeyPair: '');
    // _client.getValidationResult(
    //   key: ValidationResultKeys.email,
    //   validatorPK: 'validatorPK',
    //   secretKey: 'secretKey',
    // );
    // // set hasValidatedEmail
    // _client.getValidationResult(
    //   key: ValidationResultKeys.phone,
    //   validatorPK: 'validatorPK',
    //   secretKey: 'secretKey',
    // );
    // // set hasValidatedPhone
    // _client.getValidationResult(
    //   key: ValidationResultKeys.smileId,
    //   validatorPK: 'validatorPK',
    //   secretKey: 'secretKey',
    // );
    // // set hasPassedKyc
  }

  bool _hasValidatedEmail = false;
  bool _hasValidatedPhone = false;
  bool _hasPassedKyc = false;

  bool get hasValidatedEmail => _hasValidatedEmail;
  bool get hasValidatedPhone => _hasValidatedPhone;
  bool get hasPassedKyc => _hasPassedKyc;

  set hasValidatedEmail(bool value) {
    if (value == _hasValidatedEmail) return;
    _hasValidatedEmail = value;
    notifyListeners();
  }

  set hasValidatedPhone(bool value) {
    if (value == _hasValidatedPhone) return;
    _hasValidatedPhone = value;
    notifyListeners();
  }

  set hasPassedKyc(bool value) {
    if (value == _hasPassedKyc) return;
    _hasPassedKyc = value;
    notifyListeners();
  }
}
