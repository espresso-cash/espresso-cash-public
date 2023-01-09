import 'package:solana/src/crypto/ed25519_hd_public_key.dart';
import 'package:solana/src/encoder/instruction.dart';
import 'package:solana/src/encoder/message_address_table_lookup.dart';

class LoadedAddresses {
  LoadedAddresses({
    required this.writable,
    required this.readonly,
  });

  final List<Ed25519HDPublicKey> writable;
  final List<Ed25519HDPublicKey> readonly;
}

class MessageAccountKeys {
  MessageAccountKeys({
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

  Ed25519HDPublicKey? get(int index) {
    for (final keySegment in keySegments()) {
      if (index < keySegment.length) {
        return keySegment[index];
      } else {
        index -= keySegment.length;
      }
    }
  }

  int get length => keySegments().expand((x) => x).length;

  List<MessageCompiledInstruction> compileInstructions(
    List<Instruction> instructions,
  ) {
    // Bail early if any account indexes would overflow a u8
    const u8max = 255;
    if (length > u8max + 1) {
      throw Exception('Account index overflow encountered during compilation');
    }

    final keyIndexMap = <String, int>{};

    keySegments().expand((x) => x).toList().asMap().forEach((index, key) {
      keyIndexMap[key.toBase58()] = index;
    });

    int findKeyIndex(Ed25519HDPublicKey key) {
      final keyIndex = keyIndexMap[key.toBase58()];
      if (keyIndex == null) {
        throw Exception(
          'Encountered an unknown instruction account key during compilation',
        );
      }

      return keyIndex;
    }

    return instructions
        .map(
          (instruction) => MessageCompiledInstruction(
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
