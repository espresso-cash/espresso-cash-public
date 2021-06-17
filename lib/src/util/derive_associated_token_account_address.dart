import 'package:cryptography/cryptography.dart' as crypto;
import 'package:solana/solana.dart';
import 'package:solana/src/base58/base58.dart' as base58;
import 'package:solana/src/constants/constants.dart';

const _nonce = 255;
final _sha256 = crypto.Sha256();
const _magicWord = 'ProgramDerivedAddress';

/// Derive the associated token account address for [walletAddress] and
/// for the [mintAddress] SPL token.
///
/// In order to send SPL tokens we need to derive the associated address
/// as per [read this link for more information][associated token account]
///
/// [associated token account]: https://spl.solana.com/associated-token-account
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
  final address = base58.encode(data);
  if (!isValidAddress(address)) {
    throw ArgumentError('derived address is not valid');
  }
  return base58.encode(data);
}
