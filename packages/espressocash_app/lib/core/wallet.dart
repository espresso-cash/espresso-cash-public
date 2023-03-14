import 'package:flutter/foundation.dart';
import 'package:solana/solana.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

import 'accounts/bl/ec_wallet.dart';

Future<ECWallet> createWallet({
  required String mnemonic,
  required int account,
}) async {
  final wallet =
      await compute(_createKeyPair, KeyPairParams(mnemonic, account));

  return LocalWallet(wallet, wallet: HDWallet.createWithMnemonic(mnemonic));
}

Future<Ed25519HDKeyPair> _createKeyPair(KeyPairParams params) =>
    Ed25519HDKeyPair.fromMnemonic(
      params.mnemonic,
      change: params.account,
    );

@immutable
class KeyPairParams {
  const KeyPairParams(this.mnemonic, this.account);

  final String mnemonic;
  final int account;
}
