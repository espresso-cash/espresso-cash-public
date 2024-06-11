import 'dart:typed_data';

import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';

Future<StellarWallet> createStellarWallet({required String mnemonic}) async {
  final wallet = await Wallet.from(mnemonic);

  return StellarWallet(await wallet.getKeyPair());
}

class StellarWallet {
  StellarWallet(this.keyPair) {
    print('Created wallet with address: $address');
  }

  final KeyPair keyPair;

  String get address => keyPair.accountId;

  Uint8List sign(Uint8List payload) => keyPair.sign(payload);
}
