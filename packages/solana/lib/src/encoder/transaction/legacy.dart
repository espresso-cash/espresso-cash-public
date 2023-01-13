import 'package:borsh_annotation/borsh_annotation.dart';
import 'package:collection/collection.dart';
import 'package:solana/base58.dart';
import 'package:solana/src/crypto/crypto.dart';
import 'package:solana/src/encoder/encoder.dart';
import 'package:solana/src/encoder/message_header.dart';

class TxLegacy implements TxData {
  TxLegacy({
    required this.header,
    required this.accounts,
    required this.blockhash,
    required this.instructions,
  });

  factory TxLegacy.decompile(Iterable<int> data) {
    final reader =
        BinaryReader(Uint8List.fromList(data.toList()).buffer.asByteData());

    final int numRequiredSignatures = reader.readU8();

    if (numRequiredSignatures != (numRequiredSignatures & 0x7f)) {
      throw const FormatException(
        'Versioned messages must be deserialized with TxV0.decompile()',
      );
    }

    final header = MessageHeader(
      numRequiredSignatures: numRequiredSignatures,
      numReadonlySignedAccounts: reader.readU8(),
      numReadonlyUnsignedAccounts: reader.readU8(),
    );

    final accountsLength = reader.readCompactU16Value();
    final lastWriteableSignerIndex =
        header.numRequiredSignatures - header.numReadonlySignedAccounts;
    final lastWriteableNonSigner =
        accountsLength - header.numReadonlyUnsignedAccounts;

    final accounts = reader
        .readFixedArray(
          accountsLength,
          () => reader.readFixedArray(32, reader.readU8),
        )
        .map(Ed25519HDPublicKey.new)
        .mapIndexed(
      (i, a) {
        final isSigner = i < header.numRequiredSignatures;

        return AccountMeta(
          pubKey: a,
          isWriteable: isSigner
              ? i < lastWriteableSignerIndex
              : i < lastWriteableNonSigner,
          isSigner: isSigner,
        );
      },
    ).toList();

    final blockhash = reader.readFixedArray(32, reader.readU8);

    final instructionsLength = reader.readCompactU16Value();

    final instructions = reader.readFixedArray(
      instructionsLength,
      () => _decompileInstruction(reader, accounts),
    );

    return TxLegacy(
      header: header,
      accounts: accounts,
      blockhash: base58encode(blockhash),
      instructions: instructions,
    );
  }

  @override
  final MessageHeader header;

  @override
  final String blockhash;

  final List<AccountMeta> accounts;
  final List<Instruction> instructions;
}

Instruction _decompileInstruction(
  BinaryReader reader,
  List<AccountMeta> allAccounts,
) {
  final programIdIndex = reader.readU8();
  final programId = allAccounts[programIdIndex].pubKey;

  final accountsLength = reader.readCompactU16Value();

  final accountIndexes =
      reader.readFixedArray(accountsLength, reader.readU8).toList();
  final accounts = accountIndexes.map((i) => allAccounts[i]).toList();

  final dataLength = reader.readCompactU16Value();

  return Instruction(
    programId: programId,
    accounts: accounts,
    data: ByteArray(reader.readFixedArray(dataLength, reader.readU8)),
  );
}
