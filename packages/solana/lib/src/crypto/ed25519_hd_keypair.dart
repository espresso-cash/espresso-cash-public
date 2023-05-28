import 'dart:async';
import 'dart:math';

import 'package:bip39/bip39.dart' as bip39;
import 'package:cryptography/cryptography.dart'
    show Ed25519, KeyPair, KeyPairType, SimpleKeyPairData, SimplePublicKey;
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/src/crypto/ed25519_hd_keypair_data.dart';
import 'package:solana/src/crypto/ed25519_hd_public_key.dart';
import 'package:solana/src/crypto/signature.dart';
import 'package:solana/src/encoder/message/message.dart';
import 'package:solana/src/encoder/signed_tx.dart';

/// Signs solana transactions using the ed25519 elliptic curve
class Ed25519HDKeyPair extends KeyPair {
  Ed25519HDKeyPair._({
    required List<int> privateKey,
    required this.publicKey,
  }) : _privateKey = privateKey;

  /// Construct a new [Ed25519HDKeyPair] from a [seed] and a derivation path [hdPath].
  static Future<Ed25519HDKeyPair> fromSeedWithHdPath({
    required List<int> seed,
    required String hdPath,
  }) async {
    final KeyData keyData = await ED25519_HD_KEY.derivePath(hdPath, seed);

    return Ed25519HDKeyPair._(
      privateKey: keyData.key,
      publicKey: Ed25519HDPublicKey(
        await ED25519_HD_KEY.getPublicKey(keyData.key, false),
      ),
    );
  }

  static Future<Ed25519HDKeyPair> fromPrivateKeyBytes({
    required List<int> privateKey,
  }) async =>
      Ed25519HDKeyPair._(
        privateKey: privateKey,
        publicKey: Ed25519HDPublicKey(
          await ED25519_HD_KEY.getPublicKey(privateKey, false),
        ),
      );

  /// Generate a new random [Ed25519HDKeyPair]
  static Future<Ed25519HDKeyPair> random() async {
    int random(int _) => _random.nextInt(256);

    // Create the seed
    final List<int> seedBytes = List<int>.generate(32, random);

    // Finally, create a new wallet
    return Ed25519HDKeyPair.fromSeedWithHdPath(
      seed: seedBytes,
      hdPath: "m/44'/501'/0'/0'",
    );
  }

  /// Creates and initializes the [account]th SolanaWallet and the
  /// [change]th account for the given bip39 [mnemonic] string of
  /// 12 words.
  ///
  /// Omitting [account] or [change] means they will be `null`
  /// with the following rules of the meaning of `null` in this context.
  ///
  /// If either [account] or [change] is `null`, and the other
  /// is not, then it will be taken to be zero.
  ///
  /// If [account] and [change] are both `null`, then we derive
  /// the address that would be returned by using
  ///
  ///     solana-keygen pubkey prompt://
  ///
  /// and passing the [mnemonic] seed phrase
  static Future<Ed25519HDKeyPair> fromMnemonic(
    String mnemonic, {
    int? account,
    int? change,
  }) async {
    final List<int> seed = bip39.mnemonicToSeed(mnemonic);

    return Ed25519HDKeyPair.fromSeedWithHdPath(
      seed: seed,
      hdPath: getHDPath(account, change),
    );
  }

  /// Sign a solana program message
  Future<SignedTx> signMessage({
    required Message message,
    required String recentBlockhash,
  }) async {
    final compiledMessage = message.compile(
      recentBlockhash: recentBlockhash,
      feePayer: publicKey,
    );
    final signature = await sign(compiledMessage.toByteArray());

    return SignedTx(signatures: [signature], compiledMessage: compiledMessage);
  }

  @override
  Future<Ed25519HDKeyPairData> extract() async => Ed25519HDKeyPairData(
        _privateKey,
        publicKey: publicKey,
      );

  @override
  Future<Ed25519HDPublicKey> extractPublicKey() =>
      Future<Ed25519HDPublicKey>.value(publicKey);

  /// Returns a Future that resolves to the result of signing [data] with the
  /// private key held internally by a given instance.
  Future<Signature> sign(Iterable<int> data) async {
    // DartEd25519 expects SimpleKeyPairData as a keypair, but it's sealed, so
    // we cannot make this class a subclass of SimpleKeyPairData, so we sign it
    // with the instance of SimpleKeyPairData and then create a new Signature
    // with our public key.
    final keypair = SimpleKeyPairData(
      _privateKey,
      publicKey: SimplePublicKey(
        publicKey.bytes,
        type: KeyPairType.ed25519,
      ),
      type: KeyPairType.ed25519,
    );

    final signature = await _ed25519.sign(
      data.toList(growable: false),
      keyPair: keypair,
    );

    return Signature(signature.bytes, publicKey: publicKey);
  }

  /// Build a derivation path with [account] and [change]
  @visibleForTesting
  static String getHDPath(int? account, int? change) {
    final path = StringBuffer("m/44'/501'");

    if (account != null) {
      path.write("/$account'");
    } else if (account == null && change != null) {
      path.write("/0'");
    }

    if (change != null) {
      path.write("/$change'");
    }

    return path.toString();
  }

  /// The address or public key of this wallet
  static final _ed25519 = Ed25519();

  final List<int> _privateKey;
  final Ed25519HDPublicKey publicKey;

  String get address => publicKey.toBase58();
}

final _random = Random.secure();
