import 'package:bip39/bip39.dart' as bip39;
import 'package:cryptography/cryptography.dart';
import 'package:solana_dart/src/base58/base58.dart' as base58;

/// Signs transactions to be sent to a Solana Cluster
class SolanaWallet {
  SolanaWallet._fromKeyPair(KeyPair keyPair)
      : _keyPair = keyPair,
        address = base58.encode(keyPair.publicKey.bytes);

  /// Creates and initializes a new SolanaWallet for the given bip39
  /// [mnemonic] string of 12 words
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

  /// Returns a Future that resolves to the result of signing
  /// [data] with the private key held internally by a given
  /// instance
  Future<Signature> sign(List<int> data) {
    return ed25519.sign(data, _keyPair);
  }

  /// The address or public key of this wallet
  final String address;

  final KeyPair _keyPair;
}
