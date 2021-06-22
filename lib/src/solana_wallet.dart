import 'dart:math';

import 'package:bip39/bip39.dart' as bip39;
import 'package:cryptography/cryptography.dart'
    show KeyPair, PublicKey, SimplePublicKey, Ed25519;
import 'package:solana/solana.dart';
import 'package:solana/src/base58/base58.dart' as base58;
import 'package:solana/src/encoder/encoder.dart';
import 'package:solana/src/types/hd_key_pair.dart';

final _random = Random.secure();

/// Signs transactions to be sent to a Solana Cluster
class SolanaWallet {
  SolanaWallet._fromKeyPair(
    this._keyPair, {
    required this.address,
  });

  static Future<SolanaWallet> random() async {
    // Create the seed
    final List<int> seedBytes = List<int>.generate(
      32,
      (_) => _random.nextInt(256),
    );
    final KeyPair keyPair = await _deriveKeyPair(seedBytes, 0, 0);
    final PublicKey publicKey = await keyPair.extractPublicKey();
    if (publicKey is SimplePublicKey) {
      // Finally, create a new wallet
      return SolanaWallet._fromKeyPair(
        keyPair,
        address: base58.encode(publicKey.bytes),
      );
    } else {
      throw const FormatException('could not build a key pair');
    }
  }

  /// Creates and initializes the [walletIndex]th SolanaWallet and the
  /// [accountIndex]th account for the given bip39 [mnemonic] string of
  /// 12 words
  static Future<SolanaWallet> fromMnemonic(
    String mnemonic, {
    int walletIndex = 0,
    int accountIndex = 0,
  }) async {
    // Create the seed
    final List<int> seedBytes = bip39.mnemonicToSeed(mnemonic);
    final KeyPair keyPair =
        await _deriveKeyPair(seedBytes, walletIndex, accountIndex);
    final PublicKey publicKey = await keyPair.extractPublicKey();
    if (publicKey is SimplePublicKey) {
      // Finally, create a new wallet
      return SolanaWallet._fromKeyPair(
        keyPair,
        address: base58.encode(publicKey.bytes),
      );
    } else {
      throw const FormatException('could not build a key pair');
    }
  }

  static final _ed25519 = Ed25519();
  final KeyPair _keyPair;

  /// The address or public key of this wallet
  final String address;

  static String _getHDPath(int walletIndex, int accountIndex) =>
      "m/44'/501'/$walletIndex'/$accountIndex'";

  static Future<KeyPair> _deriveKeyPair(
    List<int> rawSeed,
    int walletIndex,
    int accountIndex,
  ) async {
    final List<int> seed = rawSeed;
    return HDKeyPair.fromSeed(seed, _getHDPath(walletIndex, accountIndex));
  }

  /// Returns a Future that resolves to the result of signing
  /// [data] with the private key held internally by a given
  /// instance
  Future<Signature> sign(Iterable<int> data) async => Signature.from(
        await _ed25519.sign(data.toList(growable: false), keyPair: _keyPair),
      );

  /// Sign a solana program message
  Future<SignedTx> signMessage(
    Message message,
    Blockhash recentBlockhash,
  ) async {
    final Iterable<int> messageBytes = message.compile(recentBlockhash);
    final signature = await sign(messageBytes);

    return SignedTx(
      signatures: [signature],
      messageBytes: messageBytes,
    );
  }
}
