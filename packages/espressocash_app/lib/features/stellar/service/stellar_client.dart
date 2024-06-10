import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';
import '../../accounts/auth_module.dart';
import '../constants.dart';

@lazySingleton
class StellarClient {
  const StellarClient(
    this._ecClient, {
    @stellar required StellarSDK sdk,
  }) : _sdk = sdk;

  final StellarSDK _sdk;
  final EspressoCashClient _ecClient;

  Future<String> fetchToken({required KeyPair wallet}) {
    const moneygramAuthUrl = '$moneygramBaseUrl/auth';
    final moneygramDomain = Uri.parse(moneygramBaseUrl).host;
    const clientDomain = espressoClientDomain;

    final auth = WebAuth(
      moneygramAuthUrl,
      stellarNetwork,
      moneygramSigningKey,
      moneygramDomain,
    );

    return auth.jwtToken(
      wallet.accountId,
      [wallet],
      clientDomain: clientDomain,
      clientDomainSigningDelegate: (transactionXdr) async => _ecClient
          .signChallenge(
            MoneygramChallengeSignRequestDto(signedTx: transactionXdr),
          )
          .then((e) => e.signedTx),
    );
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

  Future<bool> submitTransactionFromXdrString(
    String xdr, {
    required KeyPair userKeyPair,
  }) async {
    final envelope = AbstractTransaction.fromEnvelopeXdrString(xdr);
    final transaction = envelope as Transaction
      ..sign(userKeyPair, stellarNetwork); //TODO

    final response = await _sdk.submitTransaction(transaction);

    return response.success;
  }
}
