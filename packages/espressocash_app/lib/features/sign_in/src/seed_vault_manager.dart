// import 'package:dfunc/dfunc.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:injectable/injectable.dart';
// import 'package:solana/solana.dart';
// import 'package:solana_seed_vault/solana_seed_vault.dart';

// import '../../../config.dart';
// import '../../../core/accounts/bl/ec_wallet.dart';
// import '../../../core/file_manager.dart';
// import '../../../core/wallet.dart';

// @injectable
// class WalletManager {
//   WalletManager(
//     this._fileManager,
//     this._seedVault,
//     this._secureStorage,
//   );

//   final FileManager _fileManager;
//   final FlutterSecureStorage _secureStorage;
//   final SeedVault _seedVault;

//   Future<ECWallet> getExistingWallet();

//   Future<ECWallet> createWallet({String? phrase}) async {
//     if (phrase != null) {
//       SeedVault.instance.also
//       return _createLocalWallet(phrase, 0);
//     }

//     if (await _seedVault.isReady()) {
//       final wallet = _createSagaWallet();
//     }

//     throw Exception();
//   }

//   Future<LocalWallet> _createLocalWallet(String mnemonic, int account) =>
//       compute(
//         _createKeyPair,
//         KeyPairParams(mnemonic, account),
//       ).letAsync(LocalWallet.new);

//   Future<SagaWallet> _createSagaWallet() async {
//     final authToken =
//         await _seedVault.createSeed(Purpose.signSolanaTransaction);
//     final account = await _seedVault
//         .getParsedAccounts(authToken)
//         .letAsync((it) => it.first);
//     await _seedVault.markAccountAsValid(authToken, account);

//     return SagaWallet(account, authToken);
//   }

//   Future<void> _saveWallet(ECWallet walelt) {}
// }

// AsyncResult<SagaWallet> getExistingSagaWallet(int authToken) => tryEitherAsync(
//       (_) async {
//         final seed =
//             await SeedVault.instance.getParsedAuthorizedSeed(authToken);
//         final account = await seed.extractValidAccount();

//         return SagaWallet(account, authToken);
//       },
//     );

// AsyncResult<SagaWallet> authorizeExistingSeed() => tryEitherAsync(
//       (_) async {
//         final authToken = await SeedVault.instance
//             .authorizeSeed(Purpose.signSolanaTransaction);
//         final account = await SeedVault.instance
//             .getParsedAccounts(authToken)
//             .letAsync((it) => it.first);

//         return SagaWallet(account, authToken);
//       },
//     );

// extension on Seed {
//   Future<Account> extractValidAccount() async {
//     final accounts = this.accounts;

//     return accounts.first;
//   }
// }

// Future<Ed25519HDKeyPair> _createKeyPair(KeyPairParams params) =>
//     Ed25519HDKeyPair.fromMnemonic(
//       params.mnemonic,
//       change: params.account,
//     );

// extension on SeedVault {
//   Future<bool> isReady() async =>
//       await isAvailable(allowSimulated: !isProd) && await checkPermission();

//   Future<void> markAccountAsValid(AuthToken authToken, Account account) async {
//     await updateAccountIsUserWallet(
//       authToken: authToken,
//       accountId: account.id,
//       isUserWallet: true,
//     );
//     await updateAccountIsValid(
//       authToken: authToken,
//       accountId: account.id,
//       isValid: true,
//     );
//   }
// }
