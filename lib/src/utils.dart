import 'package:cryptography/cryptography.dart';
import 'package:solana/src/base58/base58.dart' as base58;
import 'package:solana/src/curve25519/curve25519.dart';
import 'package:solana/src/encoder/encoder.dart';

typedef HashFunc = List<int> Function(List<int> m);

abstract class Utils {
  /// Returns true if [address] is a valid ed25519 point encoded
  /// to base58.
  static bool isValidAddress(String address) {
    final data = Buffer.fromBase58(address);
    if (data.length != 32) {
      throw const FormatException(
        'invalid length, decoded address is not 32 bytes long',
      );
    }
    return _Ed25519Curve.isPointOnCurve(data);
  }

  /// Find a program address for [programId] and [seeds]
  static Future<String> findProgramAddress({
    required Iterable<Iterable<int>> seeds,
    required String programId,
  }) async {
    if (seeds.length > _maxSeeds) {
      throw const FormatException('you can give me up to $_maxSeeds seeds');
    }
    final overflowingSeed = seeds.where((s) => s.length > _maxSeedLength);
    if (overflowingSeed.isNotEmpty) {
      throw const FormatException(
          'one or more of the seeds provided is too big');
    }
    final programIdBytes = Buffer.fromBase58(programId);
    final flatSeeds = seeds.fold(<int>[], _flatten);
    int bumpSeed = _maxBumpSeed;
    while (bumpSeed >= 0) {
      try {
        return await _createProgramAddress(
          seeds: [...flatSeeds, bumpSeed],
          programId: programIdBytes,
        );
      } on FormatException {
        bumpSeed -= 1;
      }
    }

    throw const FormatException('cannot find program address with these seeds');
  }

  static Future<List<int>> _computeHash(List<int> source) async {
    final hash = await _sha256.hash(source);
    return hash.bytes;
  }

  static Future<String> _createProgramAddress({
    required Iterable<int> seeds,
    required Iterable<int> programId,
  }) async {
    final seedBytes = seeds
        .followedBy(programId)
        .followedBy(_magicWord)
        .toList(growable: false);
    final data = await _computeHash(seedBytes);
    if (_Ed25519Curve.isPointOnCurve(data)) {
      throw const FormatException(
          'failed to create address with provided seeds');
    } else {
      return base58.encode(data);
    }
  }
}

abstract class _Ed25519Curve {
  // Returns whether the point [data] is on the ed25519 curve.
  static bool isPointOnCurve(Iterable<int> data) {
    if (data.length != 32) {
      throw const FormatException(
        'invalid length, decoded address is not 32 bytes long',
      );
    }
    try {
      final compressed = CompressedEdwardsY(data.toList());
      final point = compressed.decompress();
      return !point.isSmallOrder();
    } on FormatException {
      return false;
    }
  }
}

final _sha256 = Sha256();
final _magicWord = 'ProgramDerivedAddress'.codeUnits;
const _maxBumpSeed = 255;
const _maxSeeds = 16;
const _maxSeedLength = 32;

Iterable<int> _flatten(Iterable<int> concatenated, Iterable<int> current) =>
    concatenated.followedBy(current).toList();
