import 'package:cryptography/cryptography.dart' as crypto;
import 'package:solana/src/base58/base58.dart' as base58;
import 'package:solana/src/constants/constants.dart';

const _nonce = 255;
final _sha256 = crypto.Sha256();
const _magicWord = 'ProgramDerivedAddress';

Future<String> deriveAssociatedTokenAddress({
  required String walletAddress,
  required String mintAddress,
}) async {
  final List<int> seeds = [
    ...base58.decode(walletAddress),
    ...base58.decode(TokenProgram.id),
    ...base58.decode(mintAddress),
    _nonce,
    ...base58.decode(AssociatedTokenAccountProgram.id),
    ..._magicWord.codeUnits
  ];
  final hash = await _sha256.hash(seeds);
  final data = hash.bytes.sublist(0, 32);
  return base58.encode(data);
}
