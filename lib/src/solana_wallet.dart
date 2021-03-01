import 'package:bip39/bip39.dart' as bip39;
import 'package:cryptography/cryptography.dart';
import 'package:solana_dart/src/base58/base58.dart' as base58;

class SolanaWallet {
  SolanaWallet._fromKeyPair(KeyPair keyPair)
      : _keyPair = keyPair,
        address = base58.encode(keyPair.publicKey.bytes);

  factory SolanaWallet.fromMnemonic(String mnemonic) {
    // Create the seed
    List<int> seedBytes = bip39.mnemonicToSeed(mnemonic);
    // Create a private key from the seed
    PrivateKey privateKey = PrivateKey(seedBytes.sublist(0, 32));
    // Build the key pair
    KeyPair keyPair = ed25519.newKeyPairFromSeedSync(privateKey);
    // Finally, create a new wallet
    return SolanaWallet._fromKeyPair(keyPair);
  }

  Future<Signature> sign(List<int> data) {
    return ed25519.sign(data, _keyPair);
  }

  final String address;
  final KeyPair _keyPair;
}
