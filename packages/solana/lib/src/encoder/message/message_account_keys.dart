import 'package:solana/src/crypto/ed25519_hd_public_key.dart';
import 'package:solana/src/encoder/compiled_instruction.dart';
import 'package:solana/src/encoder/instruction.dart';
import 'package:solana/src/encoder/message/loaded_addresses.dart';

class MessageAccountKeys {
  const MessageAccountKeys({
    required this.staticAccountKeys,
    this.accountKeysFromLookups,
  });

  final List<Ed25519HDPublicKey> staticAccountKeys;
  final LoadedAddresses? accountKeysFromLookups;

  List<List<Ed25519HDPublicKey>> keySegments() {
    final keySegments = [staticAccountKeys];

    final accountKeysFromLookups = this.accountKeysFromLookups;

    if (accountKeysFromLookups != null) {
      keySegments
        ..add(accountKeysFromLookups.writable)
        ..add(accountKeysFromLookups.readonly);
    }

    return keySegments;
  }

  Ed25519HDPublicKey? operator [](int index) {
    for (final keySegment in keySegments()) {
      if (index < keySegment.length) return keySegment[index];

      index -= keySegment.length;
    }
  }

  int get length => keySegments().expand((x) => x).length;

  List<CompiledInstruction> compileInstructions(
    Iterable<Instruction> instructions,
  ) {
    // Bail early if any account indexes would overflow a u8
    const u8max = 255;
    if (length > u8max + 1) {
      throw const FormatException(
        'Account index overflow encountered during compilation',
      );
    }

    final keyIndexMap = <String, int>{};

    keySegments().expand((x) => x).toList().asMap().forEach((index, key) {
      keyIndexMap[key.toBase58()] = index;
    });

    int findKeyIndex(Ed25519HDPublicKey key) {
      final keyIndex = keyIndexMap[key.toBase58()];
      if (keyIndex == null) {
        throw const FormatException(
          'Encountered an unknown instruction account key during compilation',
        );
      }

      return keyIndex;
    }

    return instructions
        .map(
          (instruction) => CompiledInstruction(
            programIdIndex: findKeyIndex(instruction.programId),
            accountKeyIndexes: instruction.accounts
                .map((meta) => findKeyIndex(meta.pubKey))
                .toList(),
            data: instruction.data,
          ),
        )
        .toList();
  }
}
