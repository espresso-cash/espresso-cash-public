import 'package:cryptography/cryptography.dart';
import 'package:solana/src/curve25519/compressed_edwards_y.dart';

import 'base58/encode.dart';
import 'encoder/buffer.dart';

typedef HashFunc = List<int> Function(List<int> m);

/// Returns true if [address] is a valid ed25519 point encoded
/// to base58.
bool isValidAddress(String address) {
  final data = Buffer.fromBase58(address);
  if (data.length != 32) {
    throw const FormatException(
      'invalid length, decoded address is not 32 bytes long',
    );
  }
  return isPointOnEd25519Curve(data);
}

/// Find a program address for [programId] and [seeds]
Future<String> findProgramAddress({
  required Iterable<Iterable<int>> seeds,
  required String programId,
}) async {
  if (seeds.length > _maxSeeds) {
    throw const FormatException('you can give me up to $_maxSeeds seeds');
  }
  final overflowingSeed = seeds.where((s) => s.length > _maxSeedLength);
  if (overflowingSeed.isNotEmpty) {
    throw const FormatException('one or more of the seeds provided is too big');
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

Future<List<int>> _computeHash(List<int> source) async {
  final hash = await _sha256.hash(source);
  return hash.bytes;
}

Future<String> _createProgramAddress({
  required Iterable<int> seeds,
  required Iterable<int> programId,
}) async {
  final seedBytes = seeds
      .followedBy(programId)
      .followedBy(_magicWord)
      .toList(growable: false);
  final data = await _computeHash(seedBytes);
  if (isPointOnEd25519Curve(data)) {
    throw const FormatException('failed to create address with provided seeds');
  } else {
    return base58encode(data);
  }
}

// Returns whether the point [data] is on the ed25519 curve.
bool isPointOnEd25519Curve(Iterable<int> data) {
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

final _sha256 = Sha256();
final _magicWord = 'ProgramDerivedAddress'.codeUnits;
const _maxBumpSeed = 255;
const _maxSeeds = 16;
const _maxSeedLength = 32;

Iterable<int> _flatten(Iterable<int> concatenated, Iterable<int> current) =>
    concatenated.followedBy(current).toList();
