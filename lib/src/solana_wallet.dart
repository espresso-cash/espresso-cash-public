import 'package:bip39/bip39.dart' as bip39;
import 'package:cryptography/cryptography.dart';
import 'package:solana/src/base58/base58.dart' as base58;
import 'package:solana/src/types/hd_key_pair.dart';

/// Signs transactions to be sent to a Solana Cluster
class SolanaWallet {
  SolanaWallet._fromKeyPair(
    this._keyPair, {
    required this.address,
  });

  /// Creates and initializes a new SolanaWallet for the given bip39
  /// [mnemonic] string of 12 words
  static Future<SolanaWallet> fromMnemonic(
    String mnemonic, {
    int? account,
  }) async {
    // Create the seed
    final List<int> seedBytes = bip39.mnemonicToSeed(mnemonic);
    final KeyPair keyPair = await _deriveKeyPair(seedBytes, account);
    final PublicKey publicKey = await keyPair.extractPublicKey();
    if (publicKey is SimplePublicKey) {
      // Finally, create a new wallet
      return SolanaWallet._fromKeyPair(
        keyPair,
        address: base58.encode(publicKey.bytes),
      );
    } else {
      throw Exception('could not build a key pair');
    }
  }

  /// Returns a Future that resolves to the result of signing
  /// [data] with the private key held internally by a given
  /// instance
  Future<Signature> sign(List<int> data) async =>
      _ed25519.sign(data, keyPair: _keyPair);

  /// The address or public key of this wallet
  static final _ed25519 = Ed25519();
  final KeyPair _keyPair;
  final String address;

  static String _getHDPath(int account) => "m/44'/501'/${account - 1}'";

  static Future<KeyPair> _deriveKeyPair(
    List<int> rawSeed,
    int? account,
  ) async {
    final List<int> seed = rawSeed.sublist(0, 32);
    if (account == null || account == 0) {
      return _ed25519.newKeyPairFromSeed(seed);
    } else {
      return HDKeyPair.fromSeed(seed, _getHDPath(account));
    }
  }
}
