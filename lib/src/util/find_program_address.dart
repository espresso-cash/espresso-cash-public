import 'package:cryptography/cryptography.dart' as crypto;
import 'package:solana/src/base58/base58.dart' as base58;
import 'package:solana/src/util/is_valid_address.dart';

Future<List<int>> computeHash(List<int> source) async {
  final hash = await _sha256.hash(source);
  return hash.bytes;
}

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
  final programIdBytes = base58.decode(programId);
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

Future<String> _createProgramAddress({
  required Iterable<int> seeds,
  required Iterable<int> programId,
}) async {
  final seedBytes = seeds
      .followedBy(programId)
      .followedBy(_magicWord)
      .toList(growable: false);
  late final bool isOnCurve;
  final data = await computeHash(seedBytes);
  if (Ed25519Curve.isPointOnCurve(data)) {
    throw const FormatException('failed to create address with provided seeds');
  } else {
    return base58.encode(data);
  }
}

Iterable<int> _flatten(Iterable<int> concatenated, Iterable<int> current) =>
    concatenated.followedBy(current).toList();

final _sha256 = crypto.Sha256();
final _magicWord = 'ProgramDerivedAddress'.codeUnits;
const _maxBumpSeed = 255;
const _maxSeeds = 16;
const _maxSeedLength = 32;
