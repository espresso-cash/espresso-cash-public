import 'dart:convert';

import 'package:borsh_annotation/borsh_annotation.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/base58.dart';
import 'package:solana/src/constants.dart';
import 'package:solana/src/crypto/crypto.dart';
import 'package:solana/src/encoder/compact_array.dart';
import 'package:solana/src/encoder/compact_u16.dart';
import 'package:solana/src/encoder/encoder.dart';
import 'package:solana/src/encoder/message_header.dart';

/// Represents a signed transaction that consists of the transaction message and
/// an array of signatures. The array of signatures must be populated following
/// the solana convention for the set of addresses that they belong to within
/// the message.
@immutable
class SignedTx {
  SignedTx({
    this.signatures = const Iterable<Signature>.empty(),
    required this.messageBytes,
  });

  factory SignedTx.decode(String encoded) {
    final data = base64.decode(encoded);

    return SignedTx.fromBytes(data);
  }

  factory SignedTx.fromBytes(Iterable<int> data) {
    final input = Uint8List.fromList(data.toList());
    final reader = BinaryReader(input.buffer.asByteData());
    final signaturesCount = reader.readCompactU16Value();

    final signaturesData = reader.readFixedArray(
      signaturesCount,
      () => reader.readFixedArray(signatureLength, reader.readU8),
    );

    final messageBytes = reader.buf.buffer.asUint8List(reader.offset);
    final txData = _TxData.decompile(messageBytes);

    final signatures = signaturesData.mapIndexed(
      (i, s) => Signature(s, publicKey: txData.accounts[i].pubKey),
    );

    return SignedTx(
      signatures: signatures,
      messageBytes: ByteArray(messageBytes),
    );
  }

  String get blockhash => _txData.blockhash;

  late final Message message = Message(instructions: _txData.instructions);

  List<AccountMeta> get accounts => _txData.accounts.toList();

  late final _TxData _txData = _TxData.decompile(messageBytes);

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
}

class _TxData {
  _TxData({
    required this.header,
    required this.accounts,
    required this.blockhash,
    required this.instructions,
  });

  factory _TxData.decompile(Iterable<int> data) {
    final reader =
        BinaryReader(Uint8List.fromList(data.toList()).buffer.asByteData());
    final header = MessageHeader(
      numRequiredSignatures: reader.readU8(),
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

    return _TxData(
      header: header,
      accounts: accounts,
      blockhash: base58encode(blockhash),
      instructions: instructions,
    );
  }

  final MessageHeader header;
  final List<AccountMeta> accounts;
  final String blockhash;
  final List<Instruction> instructions;
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
