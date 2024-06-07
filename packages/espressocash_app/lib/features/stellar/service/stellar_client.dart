import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';
import '../constants.dart';

class StellarClient {
  const StellarClient(this._sdk);

  final StellarSDK _sdk;

  Future<String> initiateSep10Token({required KeyPair wallet}) async {
    const moneygramAuthUrl = '$moneygramBaseUrl/auth';
    final moneygramDomain = Uri.parse(moneygramBaseUrl).host;
    const clientDomain = espressoClientDomain;

    final auth = WebAuth(
      moneygramAuthUrl,
      stellarNetwork,
      moneygramSigningKey,
      moneygramDomain,
    );

    final account = wallet.accountId;

    final transaction = await auth.getChallenge(
      account,
      null,
      null,
      clientDomain,
    );

    final StellarToml clientToml =
        await StellarToml.fromDomain(clientDomain, httpClient: auth.httpClient);
    if (clientToml.generalInformation.signingKey == null) {
      throw NoClientDomainSigningKeyFoundException(clientDomain);
    }

    final clientDomainAccountId = clientToml.generalInformation.signingKey;

    auth.validateChallenge(
      transaction,
      account,
      clientDomainAccountId,
      60 * 5,
      null,
    );

    return auth.signTransaction(transaction, [wallet]);
  }

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

  Future<double?> getUsdcBalance(String accountId) async {
    try {
      final account = await _sdk.accounts.account(accountId);

      for (final balance in account.balances) {
        if (balance.assetCode == 'USDC' &&
            balance.assetIssuer == moneygramAssetIssuer) {
          return double.parse(balance.balance);
        }
      }

      return null;
    } on Exception {
      return null;
    }
  }

  Future<bool> hasUsdcTrustline(String accountId, {double? amount}) async {
    try {
      final account = await _sdk.accounts.account(accountId);

      for (final balance in account.balances) {
        if (balance.assetCode == 'USDC' &&
            balance.assetIssuer == moneygramAssetIssuer) {
          if (amount != null) {
            final double currentBalance = double.parse(balance.balance);
            final double limit = double.tryParse(balance.limit ?? '0') ?? 0;

            return (currentBalance + amount) <= limit;
          }

          return true;
        }
      }

      return false;
    } on Exception {
      return false;
    }
  }

  Future<bool> createUsdcTrustline({
    required KeyPair userKeyPair,
    required double limit,
  }) async {
    final accountId = userKeyPair.accountId;
    final account = await _sdk.accounts.account(accountId);

    final usdc = AssetTypeCreditAlphaNum4('USDC', moneygramAssetIssuer);
    final ctob = ChangeTrustOperationBuilder(usdc, limit.toString());

    final transaction = TransactionBuilder(account)
        .addOperation(ctob.build())
        .build()
      ..sign(userKeyPair, stellarNetwork);

    final response = await _sdk.submitTransaction(transaction);

    return response.success;
  }
}
