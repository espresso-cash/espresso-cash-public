import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';

@internal
Message decompileLegacy(CompiledMessage message) {
  final header = message.header;

  final accountsLength = message.accountKeys.length;
  final lastWriteableSignerIndex =
      header.numRequiredSignatures - header.numReadonlySignedAccounts;
  final lastWriteableNonSigner =
      accountsLength - header.numReadonlyUnsignedAccounts;

  final accounts = message.accountKeys.mapIndexed(
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

  final instructions = message.instructions
      .map(
        (ix) => Instruction(
          programId: accounts[ix.programIdIndex].pubKey,
          accounts: ix.accountKeyIndexes.map((i) => accounts[i]).toList(),
          data: ix.data,
        ),
      )
      .toList();

  return Message(instructions: instructions);
}
