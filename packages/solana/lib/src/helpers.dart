import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/curve25519/compressed_edwards_y.dart';
import 'package:solana/src/rpc/dto/dto.dart';

/// Returns true if [address] is a valid ed25519 point encoded to base58.
bool isValidAddress(String address) {
  try {
    final data = ByteArray.fromBase58(address);

    return isPointOnEd25519Curve(data);
  } on Exception {
    return false;
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
    final compressed = CompressedEdwardsY(data.map(BigInt.from).toList());
    final point = compressed.decompress();

    return !point.isSmallOrder();
  } on FormatException {
    return false;
  }
}

/// Compute and derive the associated token address of [owner].
Future<Ed25519HDPublicKey> findAssociatedTokenAddress({
  required Ed25519HDPublicKey owner,
  required Ed25519HDPublicKey mint,
}) =>
    Ed25519HDPublicKey.findProgramAddress(
      seeds: [owner.bytes, TokenProgram.id.toByteArray(), mint.bytes],
      programId: AssociatedTokenAccountProgram.id,
    );

Future<SignedTx> signTransaction(
  RecentBlockhash recentBlockhash,
  Message message,
  List<Ed25519HDKeyPair> signers,
) async {
  if (signers.isEmpty) {
    throw const FormatException('you must specify at least on signer');
  }

  final CompiledMessage compiledMessage = message.compile(
    recentBlockhash: recentBlockhash.blockhash,
    feePayer: signers.first.publicKey,
  );

  return _signCompiledMessage(
    compiledMessage,
    signers,
  );
}

Future<SignedTx> signV0Transaction(
  RecentBlockhash recentBlockhash,
  Message message,
  List<Ed25519HDKeyPair> signers, {
  List<AddressLookupTableAccount> addressLookupTableAccounts = const [],
}) async {
  if (signers.isEmpty) {
    throw const FormatException('you must specify at least on signer');
  }

  final CompiledMessage compiledMessage = message.compileV0(
    recentBlockhash: recentBlockhash.blockhash,
    feePayer: signers.first.publicKey,
    addressLookupTableAccounts: addressLookupTableAccounts,
  );

  return _signCompiledMessage(
    compiledMessage,
    signers,
  );
}

Future<SignedTx> _signCompiledMessage(
  CompiledMessage compiledMessage,
  List<Ed25519HDKeyPair> signers,
) async {
  final int requiredSignaturesCount = compiledMessage.requiredSignatureCount;
  if (signers.length != requiredSignaturesCount) {
    throw FormatException(
      'your message requires $requiredSignaturesCount signatures but '
      'you provided ${signers.length}',
    );
  }

  // FIXME(IA): signatures must match signers in the message accounts sorting
  final List<Signature> signatures = await Future.wait(
    signers.map((signer) => signer.sign(compiledMessage.toByteArray())),
  );

  return SignedTx(
    compiledMessage: compiledMessage,
    signatures: signatures,
  );
}
