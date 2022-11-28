import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

const metaplexMetadataProgramId = 'metaqbxxUerdq28cj1RbAWkYQm3ybzjb6a8bt518x1s';

Future<Ed25519HDPublicKey> findMetaplexMetadataProgramAddress(
  Ed25519HDPublicKey mint,
) =>
    Ed25519HDPublicKey.findProgramAddress(
      seeds: [
        'metadata'.codeUnits,
        ByteArray.fromBase58(metaplexMetadataProgramId),
        mint.toByteArray(),
      ],
      programId: Ed25519HDPublicKey.fromBase58(metaplexMetadataProgramId),
    );

Future<Ed25519HDPublicKey> findMetaplexEditionProgramAddress(
  Ed25519HDPublicKey mint,
) =>
    Ed25519HDPublicKey.findProgramAddress(
      seeds: [
        'metadata'.codeUnits,
        ByteArray.fromBase58(metaplexMetadataProgramId),
        mint.toByteArray(),
        'edition'.codeUnits,
      ],
      programId: Ed25519HDPublicKey.fromBase58(metaplexMetadataProgramId),
    );
