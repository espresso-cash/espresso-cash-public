import 'package:dio/dio.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';

import '../config.dart';

extension DioErrorExt on DioError {
  EspressoCashError? toEspressoCashError() {
    final data = response?.data;

    if (data is! Map<String, dynamic>) return null;

    try {
      final error = EspressoCashException.fromJson(data);

      return error.error;
    } on Object {
      return null;
    }
  }
}

extension SeedVaultExt on SeedVault {
  Future<bool> isReady() async =>
      await isAvailable(allowSimulated: !isProd) && await checkPermission();

  Future<void> updateAccountData(AuthToken authToken, Account account) async {
    await updateAccountIsValid(
      authToken: authToken,
      accountId: account.id,
      isValid: true,
    );
    await updateAccountIsUserWallet(
      authToken: authToken,
      accountId: account.id,
      isUserWallet: true,
    );
  }
}
