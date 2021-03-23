import 'package:bip39/bip39.dart' as bip39;
import 'package:cryptography/cryptography.dart';
import 'package:solana/src/base58/base58.dart' as base58;

/// Signs transactions to be sent to a Solana Cluster
class SolanaWallet {
  SolanaWallet._fromKeyPair(KeyPair keyPair, this.address) : _keyPair = keyPair;

  static final _ed25519 = Ed25519();

  /// Creates and initializes a new SolanaWallet for the given bip39
  /// [mnemonic] string of 12 words
  static Future<SolanaWallet> fromMnemonic(String mnemonic) async {
    // Create the seed
    final List<int> seedBytes = bip39.mnemonicToSeed(mnemonic);
    // Create a private key from the seed
    final SecretKeyData privateKey = SecretKeyData(seedBytes.sublist(0, 32));
    // Build the key pair
    final keyPair = await _ed25519.newKeyPairFromSeed(privateKey.bytes);
    final address = base58.encode((await keyPair.extractPublicKey()).bytes);
    // Finally, create a new wallet
    return SolanaWallet._fromKeyPair(keyPair, address);
  }

  /// Returns a Future that resolves to the result of signing
  /// [data] with the private key held internally by a given
  /// instance
  Future<Signature> sign(List<int> data) =>
      _ed25519.sign(data, keyPair: _keyPair);

  /// The address or public key of this wallet
  final String address;

  final KeyPair _keyPair;
}
