import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';

class StellarClient {
  const StellarClient(this._sdk);

  final StellarSDK _sdk;

  Future<double> getXlmBalance(String accountId) async {
    try {
      final account = await _sdk.accounts.account(accountId);
      final nativeAsset = AssetTypeNative();

      for (final balance in account.balances) {
        if (balance.assetType == nativeAsset.type) {
          return double.parse(balance.balance);
        }
      }
    } on Exception {
      return 0.0;
    }

    return 0.0;
  }
}
