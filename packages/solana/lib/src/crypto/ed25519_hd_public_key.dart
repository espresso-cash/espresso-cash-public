import 'package:collection/collection.dart';
import 'package:cryptography/cryptography.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/base58.dart';
import 'package:solana/src/encoder/byte_array.dart';
import 'package:solana/src/encoder/encoder.dart';
import 'package:solana/src/helpers.dart';

@immutable
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
    final buffer = ByteArray.merge([
      fromPublicKey.toByteArray(),
      ByteArray(seed.codeUnits),
      programId.toByteArray(),
    ]).toList(growable: false);
    final hash = await _computeHash(buffer);

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
        'failed to create address with provided seeds',
      );
    }

    return Ed25519HDPublicKey(data);
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
        'one or more of the seeds provided is too big',
      );
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

  ByteArray toByteArray() => ByteArray(bytes);

  @override
  String toString() => toBase58();

  @override
  KeyPairType<KeyPairData, PublicKey> get type => KeyPairType.ed25519;

  @override
  int get hashCode => const ListEquality<int>().hash(bytes);

  @override
  bool operator ==(Object other) =>
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
