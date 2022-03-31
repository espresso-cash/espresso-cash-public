import 'dart:async';
import 'dart:math';

import 'package:bip39/bip39.dart' as bip39;
import 'package:cryptography/cryptography.dart'
    show Ed25519, KeyPair, KeyPairType, PublicKey, Sha256;
import 'package:cryptography/src/cryptography/key_pair.dart';
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/base58.dart';
import 'package:solana/src/encoder/buffer.dart';
import 'package:solana/src/encoder/message.dart';
import 'package:solana/src/encoder/signature.dart';
import 'package:solana/src/encoder/signed_tx.dart';
import 'package:solana/src/helpers.dart';

/// Signs solana transactions using the ed25519 elliptic curve
class Ed25519HDKeyPair extends KeyPair {
  Ed25519HDKeyPair._({
    required List<int> privateKey,
    required List<int> publicKey,
  })  : _privateKey = privateKey,
        _publicKey = publicKey,
        // We pre-compute this in order to avoid doing it
        // over and over because it's needed often.
        address = base58encode(publicKey);

  /// Construct a new [Ed25519HDKeyPair] from a [seed] and a derivation path [hdPath].
  static Future<Ed25519HDKeyPair> fromSeedWithHdPath({
    required List<int> seed,
    required String hdPath,
  }) async {
    final KeyData _keyData = await ED25519_HD_KEY.derivePath(hdPath, seed);

    return Ed25519HDKeyPair._(
      privateKey: _keyData.key,
      publicKey: await ED25519_HD_KEY.getPublicKey(_keyData.key, false),
    );
  }

  static Future<Ed25519HDKeyPair> fromPrivateKeyBytes({
    required List<int> privateKey,
  }) async =>
      Ed25519HDKeyPair._(
        privateKey: privateKey,
        publicKey: await ED25519_HD_KEY.getPublicKey(privateKey, false),
      );

  /// Generate a new random [Ed25519HDKeyPair]
  static Future<Ed25519HDKeyPair> random() async {
    final random = (int _) => _random.nextInt(256);
    // Create the seed
    final List<int> seedBytes = List<int>.generate(32, random);
    // final PublicKey publicKey = await keyPair.extractPublicKey();
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
    int account = 0,
    int change = 0,
  }) async {
    final List<int> seed = bip39.mnemonicToSeed(mnemonic);
    return Ed25519HDKeyPair.fromSeedWithHdPath(
      seed: seed,
      hdPath: _getHDPath(account, change),
    );
  }

  /// Sign a solana program message
  Future<SignedTx> signMessage({
    required Message message,
    // FIXME: should be string (no knowledge of these structures is needed here)
    required String recentBlockhash,
  }) async {
    final compiledMessage = message.compile(
      recentBlockhash: recentBlockhash,
      feePayer: await extractPublicKey(),
    );
    final signature = await sign(compiledMessage.data);

    return SignedTx(
      signatures: [signature],
      messageBytes: compiledMessage.data,
    );
  }

  @override
  Future<Ed25519HDKeyPairData> extract() async => Ed25519HDKeyPairData(
        _privateKey,
        publicKey: extractPublicKey(),
      );

  @override
  Future<Ed25519HDPublicKey> extractPublicKey() =>
      Future<Ed25519HDPublicKey>.value(Ed25519HDPublicKey(_publicKey));

  /// Returns a Future that resolves to the result of signing
  /// [data] with the private key held internally by a given
  /// instance
  Future<Signature> sign(Iterable<int> data) async => Signature.from(
        await _ed25519.sign(data.toList(growable: false), keyPair: this),
      );

  /// Build a derivation path with [account] and [change]
  static String _getHDPath(int account, int change) =>
      "m/44'/501'/$account'/$change'";

  /// The address or public key of this wallet
  static final _ed25519 = Ed25519();

  final List<int> _privateKey;
  final List<int> _publicKey;
  final String address;
}

final _random = Random.secure();

class Ed25519HDKeyPairData implements KeyPairData {
  Ed25519HDKeyPairData(
    this.bytes, {
    required FutureOr<Ed25519HDPublicKey> publicKey,
  }) : _publicKey = publicKey;

  final List<int> bytes;

  final FutureOr<Ed25519HDPublicKey> _publicKey;

  @override
  Future<Ed25519HDKeyPairData> extract() => Future.value(this);

  @override
  Future<Ed25519HDPublicKey> extractPublicKey() async => _publicKey;

  @override
  KeyPairType<KeyPairData, PublicKey> get type => KeyPairType.ed25519;
}

class Ed25519HDPublicKey implements PublicKey {
  const Ed25519HDPublicKey(this.bytes);

  factory Ed25519HDPublicKey.fromBase58(String data) {
    final bytes = base58decode(data);
    if (bytes.length != 32) {
      throw ArgumentError.value(
        data,
        'data',
        'Expected 32 bytes, got ${bytes.length}',
      );
    }

    return Ed25519HDPublicKey(bytes);
  }

  static Future<Ed25519HDPublicKey> createWithSeed({
    required Ed25519HDPublicKey fromPublicKey,
    required String seed,
    required Ed25519HDPublicKey programId,
  }) async {
    final buffer = Buffer.fromConcatenatedByteArrays([
      fromPublicKey.bytes,
      seed.codeUnits,
      programId.bytes,
    ]).toList(growable: false);
    final hash = (await _computeHash(buffer));

    return Ed25519HDPublicKey(hash);
  }

  /// Derives a program address from seeds and a program ID.
  static Future<Ed25519HDPublicKey> createProgramAddress({
    required Iterable<int> seeds,
    required Ed25519HDPublicKey programId,
  }) async {
    final seedBytes = seeds
        .followedBy(programId.bytes)
        .followedBy(_magicWord)
        .toList(growable: false);
    final data = await _computeHash(seedBytes);
    if (isPointOnEd25519Curve(data)) {
      throw const FormatException(
          'failed to create address with provided seeds');
    } else {
      return Ed25519HDPublicKey(data);
    }
  }

  /// Finds a valid program address.
  ///
  /// Valid program addresses must fall off the ed25519 curve. This function
  /// iterates a nonce until it finds one that when combined with the seeds
  /// results in a valid program address.
  static Future<Ed25519HDPublicKey> findProgramAddress({
    required Iterable<Iterable<int>> seeds,
    required Ed25519HDPublicKey programId,
  }) async {
    if (seeds.length > _maxSeeds) {
      throw const FormatException('you can give me up to $_maxSeeds seeds');
    }
    final overflowingSeed = seeds.where((s) => s.length > _maxSeedLength);
    if (overflowingSeed.isNotEmpty) {
      throw const FormatException(
          'one or more of the seeds provided is too big');
    }
    final flatSeeds = seeds.fold(<int>[], _flatten);
    int bumpSeed = _maxBumpSeed;
    while (bumpSeed >= 0) {
      try {
        return await createProgramAddress(
          seeds: [...flatSeeds, bumpSeed],
          programId: programId,
        );
      } on FormatException {
        bumpSeed -= 1;
      }
    }

    throw const FormatException('cannot find program address with these seeds');
  }

  final List<int> bytes;

  String toBase58() => base58encode(bytes);

  Buffer toBuffer() => Buffer.fromIterable(bytes);

  @override
  KeyPairType<KeyPairData, PublicKey> get type => KeyPairType.ed25519;

  @override
  int get hashCode => const ListEquality<int>().hash(bytes);

  @override
  bool operator ==(other) =>
      other is Ed25519HDPublicKey &&
      const ListEquality<int>().equals(bytes, other.bytes);
}

final _sha256 = Sha256();
final _magicWord = 'ProgramDerivedAddress'.codeUnits;
const _maxBumpSeed = 255;
const _maxSeeds = 16;
const _maxSeedLength = 32;

Iterable<int> _flatten(Iterable<int> concatenated, Iterable<int> current) =>
    concatenated.followedBy(current).toList();

Future<List<int>> _computeHash(List<int> source) async {
  final hash = await _sha256.hash(source);
  return hash.bytes;
}
