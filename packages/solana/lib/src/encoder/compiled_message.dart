import 'package:borsh_annotation/borsh_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/base58.dart';
import 'package:solana/src/crypto/ed25519_hd_public_key.dart';
import 'package:solana/src/encoder/byte_array.dart';
import 'package:solana/src/encoder/compact_array.dart';
import 'package:solana/src/encoder/compiled_instruction.dart';
import 'package:solana/src/encoder/message_address_table_lookup.dart';
import 'package:solana/src/encoder/message_header.dart';
import 'package:solana/src/encoder/signed_tx.dart';
import 'package:solana/src/encoder/transaction_version.dart';

part 'compiled_message.freezed.dart';

@freezed
class CompiledMessage with _$CompiledMessage {
  factory CompiledMessage(ByteArray data) {
    switch (TransactionVersion.fromByteArray(data)) {
      case TransactionVersion.legacy:
        return _decompileLegacy(data);
      case TransactionVersion.v0:
        return _decodeV0(data);
    }
  }

  const factory CompiledMessage.legacy({
    required MessageHeader header,
    required List<Ed25519HDPublicKey> accountKeys,
    required String recentBlockhash,
    required List<CompiledInstruction> instructions,
  }) = CompiledMessageLegacy;

  const factory CompiledMessage.v0({
    required MessageHeader header,
    required List<Ed25519HDPublicKey> accountKeys,
    required String recentBlockhash,
    required List<CompiledInstruction> instructions,
    required List<MessageAddressTableLookup> addressTableLookups,
  }) = CompiledMessageV0;

  const CompiledMessage._();

  ByteArray toByteArray() => map(
        legacy: (data) => ByteArray.merge([
          data.header.toByteArray(),
          CompactArray.fromIterable(
            data.accountKeys.map((e) => e.toByteArray()),
          ).toByteArray(),
          ByteArray.fromBase58(data.recentBlockhash),
          CompactArray.fromIterable(
            data.instructions.map((e) => e.toByteArray()),
          ).toByteArray(),
        ]),
        v0: (data) => ByteArray.merge([
          ByteArray.u8(1 << 7),
          data.header.toByteArray(),
          CompactArray.fromIterable(
            data.accountKeys.map((e) => e.toByteArray()),
          ).toByteArray(),
          ByteArray.fromBase58(data.recentBlockhash),
          CompactArray.fromIterable(
            data.instructions.map((e) => e.toByteArray()),
          ).toByteArray(),
          CompactArray.fromIterable(
            data.addressTableLookups.map(
              (e) => ByteArray.merge([
                e.accountKey.toByteArray(),
                CompactArray(ByteArray(e.writableIndexes)).toByteArray(),
                CompactArray(ByteArray(e.readonlyIndexes)).toByteArray(),
              ]),
            ),
          ).toByteArray(),
        ]),
      );

  int get requiredSignatureCount => version == TransactionVersion.legacy
      ? toByteArray().first
      : toByteArray().elementAt(1);

  TransactionVersion get version =>
      TransactionVersion.fromByteArray(toByteArray());
}

CompiledMessageLegacy _decompileLegacy(ByteArray data) {
  final reader =
      BinaryReader(Uint8List.fromList(data.toList()).buffer.asByteData());

  final int numRequiredSignatures = reader.readU8();

  final header = MessageHeader(
    numRequiredSignatures: numRequiredSignatures,
    numReadonlySignedAccounts: reader.readU8(),
    numReadonlyUnsignedAccounts: reader.readU8(),
  );

  final accountsLength = reader.readCompactU16Value();

  final accountKeys = reader
      .readFixedArray(
        accountsLength,
        () => reader.readFixedArray(32, reader.readU8),
      )
      .map(Ed25519HDPublicKey.new)
      .toList();

  final blockhash = reader.readFixedArray(32, reader.readU8);

  final instructionsLength = reader.readCompactU16Value();

  final instructions = reader.readFixedArray(
    instructionsLength,
    () => _decompileInstruction(reader),
  );

  return CompiledMessageLegacy(
    header: header,
    accountKeys: accountKeys,
    recentBlockhash: base58encode(blockhash),
    instructions: instructions,
  );
}

CompiledInstruction _decompileInstruction(BinaryReader reader) {
  final programIdIndex = reader.readU8();

  final accountsLength = reader.readCompactU16Value();

  final accountIndexes =
      reader.readFixedArray(accountsLength, reader.readU8).toList();

  final dataLength = reader.readCompactU16Value();

  return CompiledInstruction(
    programIdIndex: programIdIndex,
    accountKeyIndexes: accountIndexes,
    data: ByteArray(reader.readFixedArray(dataLength, reader.readU8)),
  );
}

CompiledMessageV0 _decodeV0(ByteArray data) {
  final reader =
      BinaryReader(Uint8List.fromList(data.toList()).buffer.asByteData());

  final prefix = reader.readU8();
  final maskedPrefix = prefix & 0x7f;

  if (prefix == maskedPrefix) {
    throw const FormatException(
      'Expected versioned message but received legacy message',
    );
  }

  if (maskedPrefix != 0) {
    throw FormatException(
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

  return CompiledMessageV0(
    header: header,
    accountKeys: accounts,
    recentBlockhash: base58encode(blockhash),
    instructions: compiledInstruction,
    addressTableLookups: addressTableLookups,
  );
}

CompiledInstruction _decompileMessageInstruction(BinaryReader reader) {
  final programIdIndex = reader.readU8();

  final accountKeyIndexesLength = reader.readCompactU16Value();
  final accountKeyIndexes =
      reader.readFixedArray(accountKeyIndexesLength, reader.readU8).toList();

  final dataLength = reader.readCompactU16Value();

  return CompiledInstruction(
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
