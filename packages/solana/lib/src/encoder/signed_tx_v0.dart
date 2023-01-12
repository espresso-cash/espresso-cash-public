import 'dart:convert';

import 'package:borsh_annotation/borsh_annotation.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/base58.dart';
import 'package:solana/src/constants.dart';
import 'package:solana/src/crypto/crypto.dart';
import 'package:solana/src/encoder/address_lookup_table/address_lookup_table.dart';
import 'package:solana/src/encoder/compact_array.dart';
import 'package:solana/src/encoder/compact_u16.dart';
import 'package:solana/src/encoder/encoder.dart';
import 'package:solana/src/encoder/message/account_keys.dart';
import 'package:solana/src/encoder/message/message_v0.dart';
import 'package:solana/src/encoder/message_address_table_lookup.dart';
import 'package:solana/src/encoder/message_header.dart';

/// Represents a signed transaction that consists of the transaction message and
/// an array of signatures. The array of signatures must be populated following
/// the solana convention for the set of addresses that they belong to within
/// the message.
@immutable
class SignedTxV0 {
  SignedTxV0({
    this.signatures = const Iterable<Signature>.empty(),
    required this.messageBytes,
  });

  factory SignedTxV0.decode(String encoded) {
    final data = base64.decode(encoded);

    return SignedTxV0.fromBytes(data);
  }

  factory SignedTxV0.fromBytes(Iterable<int> data) {
    final input = Uint8List.fromList(data.toList());
    final reader = BinaryReader(input.buffer.asByteData());

    final signaturesCount = reader.readCompactU16Value();

    final signaturesData = reader.readFixedArray(
      signaturesCount,
      () => reader.readFixedArray(signatureLength, reader.readU8),
    );

    final messageBytes = reader.buf.buffer.asUint8List(reader.offset);
    final txData = TxDataV0.deserialize(messageBytes);

    final signatures = signaturesData.mapIndexed(
      (i, s) => Signature(s, publicKey: txData.staticAccountKeys[i]),
    );

    return SignedTxV0(
      signatures: signatures,
      messageBytes: ByteArray(messageBytes),
    );
  }

  String get blockhash => _txData.blockhash;

  Messagev0 message({
    LoadedAddresses? accountKeysFromLookups,
    List<AddressLookupTableAccount>? addressLookupTableAccounts,
  }) =>
      _txData.decode(
        accountKeysFromLookups: accountKeysFromLookups,
        addressLookupTableAccounts: addressLookupTableAccounts,
      );

  // List<AccountMeta> get accounts => _txData.accounts.toList(); //TODO

  List<MessageAddressTableLookup> get addressTableLookups =>
      _txData.addressTableLookups.toList();

  late final TxDataV0 _txData = TxDataV0.deserialize(messageBytes);

  final Iterable<Signature> signatures;
  final ByteArray messageBytes;

  String get id => signatures.first.toBase58();

  String encode() => base64.encode(_data.toList());

  late final ByteArray _data = ByteArray.merge([
    CompactArray.fromIterable(signatures.map((e) => ByteArray(e.bytes)))
        .toByteArray(),
    messageBytes,
  ]);

  ByteArray toByteArray() => _data;

  TxDataV0 get txData => _txData;
}

class TxDataV0 {
  //TODO reset to private if not needed
  TxDataV0({
    required this.header,
    // required this.accounts, //TODO
    required this.staticAccountKeys,
    required this.blockhash,
    required this.compiledInstructions,
    required this.addressTableLookups,
  });

  factory TxDataV0.deserialize(Iterable<int> data) {
    final reader =
        BinaryReader(Uint8List.fromList(data.toList()).buffer.asByteData());

    final prefix = reader.readU8();
    final maskedPrefix = prefix & 0x7f;

    if (prefix == maskedPrefix) {
      throw Exception('Expected versioned message but received legacy message');
    }

    if (maskedPrefix != 0) {
      throw Exception(
        'Expected version 0 message but received version $maskedPrefix',
      );
    }

    final header = MessageHeader(
      numRequiredSignatures: reader.readU8(),
      numReadonlySignedAccounts: reader.readU8(),
      numReadonlyUnsignedAccounts: reader.readU8(),
    );

    final accountsLength = reader.readCompactU16Value();
    final accounts = reader
        .readFixedArray(
          accountsLength,
          () => reader.readFixedArray(32, reader.readU8),
        )
        .map(Ed25519HDPublicKey.new)
        .toList();

    final blockhash = reader.readFixedArray(32, reader.readU8);

    final instructionsLength = reader.readCompactU16Value();
    final compiledInstruction = reader.readFixedArray(
      instructionsLength,
      () => _decompileMessageInstruction(reader),
    );

    final addressLookUpLength = reader.readCompactU16Value();
    final addressTableLookups = reader.readFixedArray(
      addressLookUpLength,
      () => _decompileAddressTableLookUp(reader),
    );

    return TxDataV0(
      header: header,
      staticAccountKeys: accounts,
      blockhash: base58encode(blockhash),
      compiledInstructions: compiledInstruction,
      addressTableLookups: addressTableLookups,
    );
  }

  final MessageHeader header;
  final List<Ed25519HDPublicKey> staticAccountKeys;
  final String blockhash;
  final List<MessageCompiledInstruction> compiledInstructions;
  final List<MessageAddressTableLookup> addressTableLookups;

  Messagev0 decode({
    LoadedAddresses? accountKeysFromLookups,
    List<AddressLookupTableAccount>? addressLookupTableAccounts,
  }) {
    final numWritableSignedAccounts =
        header.numRequiredSignatures - header.numReadonlySignedAccounts;
    assert(numWritableSignedAccounts > 0, 'Message header is invalid');

    final numWritableUnsignedAccounts = staticAccountKeys.length -
        header.numRequiredSignatures -
        header.numReadonlyUnsignedAccounts;
    assert(numWritableUnsignedAccounts >= 0, 'Message header is invalid');

    final accountKeys = getAccountKeys(
      accountKeysFromLookups: accountKeysFromLookups,
      addressLookupTableAccounts: addressLookupTableAccounts,
    );
    final payer = accountKeys.get(0);

    if (payer == null) {
      throw Exception(
        'Failed to decompile message because no account keys were found',
      );
    }

    final instructions = <Instruction>[];

    for (final compiledIx in compiledInstructions) {
      final keys = <AccountMeta>[];

      for (final int keyIndex in compiledIx.accountKeyIndexes) {
        final key = accountKeys.get(keyIndex);

        if (key == null) {
          throw Exception(
            'Failed to find key for account key index $keyIndex',
          );
        }

        final isSigner = keyIndex < header.numRequiredSignatures;

        bool isWritable;
        if (isSigner) {
          isWritable = keyIndex < numWritableSignedAccounts;
        } else if (keyIndex < accountKeys.staticAccountKeys.length) {
          isWritable = keyIndex - header.numRequiredSignatures <
              numWritableUnsignedAccounts;
        } else {
          isWritable = keyIndex - accountKeys.staticAccountKeys.length <
              // accountKeysFromLookups cannot be undefined because we already found a pubkey for this index above
              accountKeys.accountKeysFromLookups!.writable.length;
        }

        keys.add(
          AccountMeta(
            pubKey: key,
            isWriteable: isWritable,
            isSigner: isSigner,
          ),
        );
      }

      final programId = accountKeys.get(compiledIx.programIdIndex);
      if (programId == null) {
        throw Exception(
          'Failed to find program id for program id index ${compiledIx.programIdIndex}',
        );
      }

      instructions.add(
        Instruction(
          programId: programId,
          accounts: keys,
          data: compiledIx.data,
        ),
      );
    }

    return Messagev0(instructions: instructions);
  }

  int numAccountKeysFromLookups() {
    int count = 0;
    for (final lookup in addressTableLookups) {
      count += lookup.readonlyIndexes.length + lookup.writableIndexes.length;
    }

    return count;
  }

  MessageAccountKeys getAccountKeys({
    LoadedAddresses? accountKeysFromLookups,
    List<AddressLookupTableAccount>? addressLookupTableAccounts,
  }) {
    LoadedAddresses? loadedAddresses;

    if (accountKeysFromLookups != null) {
      if (numAccountKeysFromLookups() !=
          accountKeysFromLookups.writable.length +
              accountKeysFromLookups.readonly.length) {
        throw Exception(
          'Failed to get account keys because of a mismatch in the number of account keys from lookups',
        );
      }

      loadedAddresses = accountKeysFromLookups;
    } else if (addressLookupTableAccounts != null) {
      loadedAddresses = resolveAddressTableLookups(
        addressLookupTableAccounts: addressLookupTableAccounts,
      );
    } else if (addressTableLookups.isNotEmpty) {
      throw Exception(
        'Failed to get account keys because address table lookups were not resolved',
      );
    }

    return MessageAccountKeys(
      staticAccountKeys: staticAccountKeys,
      accountKeysFromLookups: loadedAddresses,
    );
  }

  LoadedAddresses resolveAddressTableLookups({
    required List<AddressLookupTableAccount> addressLookupTableAccounts,
  }) {
    final LoadedAddresses accountKeysFromLookups =
        LoadedAddresses(writable: [], readonly: []);

    for (final tableLookup in addressTableLookups) {
      final tableAccount = addressLookupTableAccounts.firstWhereOrNull(
        (e) => e.key == tableLookup.accountKey,
      );

      if (tableAccount == null) {
        throw Exception(
          'Failed to find address lookup table account for table key ${tableLookup.accountKey.toBase58()}',
        );
      }

      for (final index in tableLookup.writableIndexes) {
        if (index < tableAccount.state.addresses.length) {
          accountKeysFromLookups.writable
              .add(tableAccount.state.addresses[index]);
        } else {
          throw Exception(
            'Failed to find address for index $index in address lookup table ${tableLookup.accountKey.toBase58()}',
          );
        }
      }

      for (final index in tableLookup.readonlyIndexes) {
        if (index < tableAccount.state.addresses.length) {
          accountKeysFromLookups.readonly
              .add(tableAccount.state.addresses[index]);
        } else {
          throw Exception(
            'Failed to find address for index $index in address lookup table ${tableLookup.accountKey.toBase58()}',
          );
        }
      }
    }

    return accountKeysFromLookups;
  }
}

extension on BinaryReader {
  int readCompactU16Value() {
    final keysLength = CompactU16.raw(buf.buffer.asUint8List(offset));

    for (var i = 0; i < keysLength.size; i++) {
      readU8();
    }

    return keysLength.value;
  }
}

Instruction _decompileInstruction(
  BinaryReader reader,
  List<AccountMeta> allAccounts,
) {
  final programIdIndex = reader.readU8();
  final programId = allAccounts[programIdIndex].pubKey;

  final accountKeyIndexesLength = reader.readCompactU16Value();
  final accountKeyIndexes =
      reader.readFixedArray(accountKeyIndexesLength, reader.readU8).toList();

  print(accountKeyIndexes);

  // final accounts = accountKeyIndexes.map((i) => allAccounts[i]).toList();

  final dataLength = reader.readCompactU16Value();

  return Instruction(
    programId: programId,
    accounts: [],
    data: ByteArray(reader.readFixedArray(dataLength, reader.readU8)),
  );
}

MessageCompiledInstruction _decompileMessageInstruction(BinaryReader reader) {
  final programIdIndex = reader.readU8();

  final accountKeyIndexesLength = reader.readCompactU16Value();
  final accountKeyIndexes =
      reader.readFixedArray(accountKeyIndexesLength, reader.readU8).toList();

  final dataLength = reader.readCompactU16Value();

  return MessageCompiledInstruction(
    programIdIndex: programIdIndex,
    accountKeyIndexes: accountKeyIndexes,
    data: ByteArray(reader.readFixedArray(dataLength, reader.readU8)),
  );
}

MessageAddressTableLookup _decompileAddressTableLookUp(BinaryReader reader) {
  final accountKey =
      Ed25519HDPublicKey(reader.readFixedArray(32, () => reader.readU8()));

  final writableIndexesLength = reader.readCompactU16Value();
  final writableIndexes =
      reader.readFixedArray(writableIndexesLength, reader.readU8).toList();

  final readonlyIndexesLength = reader.readCompactU16Value();

  final readonlyIndexes =
      reader.readFixedArray(readonlyIndexesLength, reader.readU8).toList();

  return MessageAddressTableLookup(
    accountKey: accountKey,
    writableIndexes: writableIndexes,
    readonlyIndexes: readonlyIndexes,
  );
}
