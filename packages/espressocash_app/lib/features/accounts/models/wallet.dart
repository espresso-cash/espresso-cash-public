import 'package:flutter/foundation.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import 'ec_wallet.dart';

Future<LocalWallet> createLocalWallet({required String mnemonic}) async {
  final wallet = await compute(
    _createKeyPair,
    KeyPairParams(mnemonic: mnemonic, account: 0, change: 0),
  );

  return LocalWallet(wallet);
}

Future<Ed25519HDKeyPair> _createKeyPair(KeyPairParams params) =>
    Ed25519HDKeyPair.fromMnemonic(params.mnemonic, change: params.change, account: params.account);

@immutable
class KeyPairParams {
  const KeyPairParams({required this.mnemonic, required this.account, required this.change});

  final String mnemonic;
  final int account;
  final int change;
}

Future<Wallet> walletFromKey({required String encodedKey}) {
  final key = ByteArray.fromBase58(encodedKey).toList();

  return Wallet.fromPrivateKeyBytes(privateKey: key);
}
