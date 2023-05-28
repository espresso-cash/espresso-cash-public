import 'package:solana/src/crypto/ed25519_hd_public_key.dart';
import 'package:solana/src/encoder/address_lookup_table/address_lookup_table.dart';
import 'package:solana/src/encoder/instruction.dart';
import 'package:solana/src/encoder/message/compiled_key_meta.dart';
import 'package:solana/src/encoder/message/loaded_addresses.dart';
import 'package:solana/src/encoder/message_address_table_lookup.dart';
import 'package:solana/src/encoder/message_header.dart';

class CompiledKeys {
  const CompiledKeys({
    required this.payer,
    required this.keyMetaMap,
  });

  factory CompiledKeys.compile({
    required List<Instruction> instructions,
    required Ed25519HDPublicKey payer,
  }) {
    final keyMetaMap = <String, CompiledKeyMeta>{};

    CompiledKeyMeta getOrInsertDefault(Ed25519HDPublicKey pubkey) =>
        keyMetaMap.putIfAbsent(
          pubkey.toBase58(),
          () => const CompiledKeyMeta(
            isSigner: false,
            isWritable: false,
            isInvoked: false,
          ),
        );

    final payerKeyMeta = getOrInsertDefault(payer);
    keyMetaMap[payer.toBase58()] = CompiledKeyMeta(
      isSigner: true,
      isWritable: true,
      isInvoked: payerKeyMeta.isInvoked,
    );

    for (final ix in instructions) {
      final programIdKeyMeta = getOrInsertDefault(ix.programId);
      keyMetaMap[ix.programId.toBase58()] = CompiledKeyMeta(
        isSigner: programIdKeyMeta.isSigner,
        isWritable: programIdKeyMeta.isWritable,
        isInvoked: true,
      );
      for (final accountMeta in ix.accounts) {
        final keyMeta = getOrInsertDefault(accountMeta.pubKey);
        keyMetaMap[accountMeta.pubKey.toBase58()] = CompiledKeyMeta(
          isSigner: keyMeta.isSigner || accountMeta.isSigner,
          isWritable: keyMeta.isWritable || accountMeta.isWriteable,
          isInvoked: keyMeta.isInvoked,
        );
      }
    }

    return CompiledKeys(payer: payer, keyMetaMap: keyMetaMap);
  }

  final Ed25519HDPublicKey payer;
  final Map<String, CompiledKeyMeta> keyMetaMap;

  MessageComponents getMessageComponents() {
    final mapEntries = keyMetaMap.entries.toList(growable: false);
    if (mapEntries.length >= 256) {
      throw const FormatException('Max static account keys length exceeded');
    }

    final writableSigners = mapEntries.where(
      (entry) => entry.value.isSigner && entry.value.isWritable,
    );
    final readonlySigners = mapEntries.where(
      (entry) => entry.value.isSigner && !entry.value.isWritable,
    );
    final writableNonSigners = mapEntries.where(
      (entry) => !entry.value.isSigner && entry.value.isWritable,
    );
    final readonlyNonSigners = mapEntries.where(
      (entry) => !entry.value.isSigner && !entry.value.isWritable,
    );

    final header = MessageHeader(
      numRequiredSignatures: writableSigners.length + readonlySigners.length,
      numReadonlySignedAccounts: readonlySigners.length,
      numReadonlyUnsignedAccounts: readonlyNonSigners.length,
    );

    {
      assert(
        writableSigners.isNotEmpty,
        'Expected at least one writable signer key',
      );
      final payerAddress = writableSigners.first.key;
      assert(
        payerAddress == payer.toBase58(),
        'Expected first writable signer key to be the fee payer',
      );
    }

    final staticAccountKeys = [
      ...writableSigners
          .map((entry) => Ed25519HDPublicKey.fromBase58(entry.key)),
      ...readonlySigners
          .map((entry) => Ed25519HDPublicKey.fromBase58(entry.key)),
      ...writableNonSigners
          .map((entry) => Ed25519HDPublicKey.fromBase58(entry.key)),
      ...readonlyNonSigners
          .map((entry) => Ed25519HDPublicKey.fromBase58(entry.key)),
    ];

    return MessageComponents(header, staticAccountKeys);
  }

  TableLookupResult? extractTableLookup(AddressLookupTableAccount lookupTable) {
    final writableDrainedKeys = _drainKeysFoundInLookupTable(
      lookupTable.state.addresses,
      (keyMeta) =>
          !keyMeta.isSigner && !keyMeta.isInvoked && keyMeta.isWritable,
    );
    final writableIndexes = writableDrainedKeys.lookupTableIndexes;
    final drainedWritableKeys = writableDrainedKeys.drainedKeys;

    final readOnlyDrainedKeys = _drainKeysFoundInLookupTable(
      lookupTable.state.addresses,
      (keyMeta) =>
          !keyMeta.isSigner && !keyMeta.isInvoked && !keyMeta.isWritable,
    );
    final readonlyIndexes = readOnlyDrainedKeys.lookupTableIndexes;
    final drainedReadonlyKeys = readOnlyDrainedKeys.drainedKeys;

    // Don't extract lookup if no keys were found
    if (writableIndexes.isEmpty && readonlyIndexes.isEmpty) {
      return null;
    }

    final lookup = MessageAddressTableLookup(
      accountKey: lookupTable.key,
      writableIndexes: writableIndexes,
      readonlyIndexes: readonlyIndexes,
    );

    final keys = LoadedAddresses(
      writable: drainedWritableKeys,
      readonly: drainedReadonlyKeys,
    );

    return TableLookupResult(lookup: lookup, keys: keys);
  }

  DrainedKeys _drainKeysFoundInLookupTable(
    List<Ed25519HDPublicKey> lookupTableEntries,
    bool Function(CompiledKeyMeta data) keyMetaFilter,
  ) {
    final lookupTableIndexes = <int>[];
    final drainedKeys = <Ed25519HDPublicKey>[];

    final mapEntries = [...keyMetaMap.entries];

    for (final entry in mapEntries) {
      final address = entry.key;
      final keyMeta = entry.value;

      if (keyMetaFilter(keyMeta)) {
        final key = Ed25519HDPublicKey.fromBase58(address);
        final lookupTableIndex =
            lookupTableEntries.indexWhere((entry) => entry == key);
        if (lookupTableIndex >= 0) {
          if (lookupTableIndex >= 256) {
            throw const FormatException('Max lookup table index exceeded');
          }
          lookupTableIndexes.add(lookupTableIndex);
          drainedKeys.add(key);
          keyMetaMap.remove(address);
        }
      }
    }

    return DrainedKeys(
      lookupTableIndexes: lookupTableIndexes,
      drainedKeys: drainedKeys,
    );
  }
}

class DrainedKeys {
  const DrainedKeys({
    required this.lookupTableIndexes,
    required this.drainedKeys,
  });

  final List<int> lookupTableIndexes;
  final List<Ed25519HDPublicKey> drainedKeys;
}

class TableLookupResult {
  const TableLookupResult({required this.lookup, required this.keys});

  final MessageAddressTableLookup lookup;
  final LoadedAddresses keys;
}

class MessageComponents {
  const MessageComponents(this.header, this.publicKeys);

  final MessageHeader header;
  final List<Ed25519HDPublicKey> publicKeys;
}
