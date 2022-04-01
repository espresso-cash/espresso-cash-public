library utilities;

import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/curve25519/compressed_edwards_y.dart';
import 'package:solana/src/encoder/encoder.dart';
import 'package:solana/src/rpc/dto/dto.dart';

typedef HashFunc = List<int> Function(List<int> m);

/// Returns true if [address] is a valid ed25519 point encoded
/// to base58.
bool isValidAddress(String address) {
  try {
    final data = Buffer.fromBase58(address);
    if (data.length != 32) {
      return false;
    }

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
    final compressed = CompressedEdwardsY(
      data.map((e) => BigInt.from(e)).toList(),
    );
    final point = compressed.decompress();

    return !point.isSmallOrder();
  } on FormatException {
    return false;
  }
}

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

  final int requiredSignaturesCount = compiledMessage.requiredSignatureCount;
  if (signers.length != requiredSignaturesCount) {
    throw FormatException(
      'your message requires $requiredSignaturesCount signatures but '
      'you provided ${signers.length}',
    );
  }

  // FIXME(IA): signatures must match signers in the message accounts sorting
  final List<Signature> signatures = await Future.wait(
    signers.map((signer) => signer.sign(compiledMessage.data)),
  );

  return SignedTx(
    messageBytes: compiledMessage.data,
    signatures: signatures,
  );
}
