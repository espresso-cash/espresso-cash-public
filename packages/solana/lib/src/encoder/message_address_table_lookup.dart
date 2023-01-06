import 'package:solana/src/crypto/ed25519_hd_public_key.dart';
import 'package:solana/src/encoder/byte_array.dart';

class MessageAddressTableLookup {
  MessageAddressTableLookup({
    required this.accountKey,
    required this.writableIndexes,
    required this.readonlyIndexes,
  });

  final Ed25519HDPublicKey accountKey;
  final List<int> writableIndexes;
  final List<int> readonlyIndexes;
}

class MessageCompiledInstruction {
  MessageCompiledInstruction({
    required this.programIdIndex,
    required this.accountKeyIndexes,
    required this.data,
  });

  final int programIdIndex;

  final List<int> accountKeyIndexes;

  final ByteArray data;
}
