import 'package:flutter/foundation.dart';
import 'package:solana/solana.dart';

Future<Wallet> createWallet({required String mnemonic, required int account}) =>
    compute(_createKeyPair, KeyPairParams(mnemonic, account));

Future<Ed25519HDKeyPair> createRandomKeyPair() =>
    compute(_createRandomKeyPair, null);

Future<Ed25519HDKeyPair> createKeyPairFromPrivateKey(List<int> key) =>
    compute(_createFromPrivateKey, key);

Future<Ed25519HDKeyPair> _createFromPrivateKey(List<int> key) async =>
    Ed25519HDKeyPair.fromPrivateKeyBytes(privateKey: key);

Future<Ed25519HDKeyPair> _createRandomKeyPair(dynamic _) =>
    Ed25519HDKeyPair.random();

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
