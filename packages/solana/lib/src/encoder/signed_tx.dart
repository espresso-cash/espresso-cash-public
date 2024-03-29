import 'dart:convert';

import 'package:borsh_annotation/borsh_annotation.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/src/constants.dart';
import 'package:solana/src/encoder/compact_array.dart';
import 'package:solana/src/encoder/compact_u16.dart';
import 'package:solana/src/encoder/encoder.dart';

part 'signed_tx.freezed.dart';

/// Represents a signed transaction that consists of the transaction message and
/// an array of signatures. The array of signatures must be populated following
/// the solana convention for the set of addresses that they belong to within
/// the message.
@freezed
class SignedTx with _$SignedTx {
  const factory SignedTx({
    @Default(<Signature>[]) List<Signature> signatures,
    required CompiledMessage compiledMessage,
  }) = _SignedTx;

  const SignedTx._();

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

    final compiledMessage = CompiledMessage(ByteArray(messageBytes));

    final signatures = signaturesData
        .mapIndexed(
          (i, s) => Signature(s, publicKey: compiledMessage.accountKeys[i]),
        )
        .toList();

    return SignedTx(
      signatures: signatures,
      compiledMessage: compiledMessage,
    );
  }

  String get blockhash => compiledMessage.recentBlockhash;

  Message decompileMessage({
    List<AddressLookupTableAccount> addressLookupTableAccounts = const [],
  }) =>
      Message.decompile(
        compiledMessage,
        addressLookupTableAccounts: addressLookupTableAccounts,
      );

  String get id => signatures.first.toBase58();

  String encode() => base64.encode(toByteArray().toList());

  TransactionVersion get version => compiledMessage.version;

  ByteArray toByteArray() => ByteArray.merge([
        CompactArray.fromIterable(signatures.map((e) => ByteArray(e.bytes)))
            .toByteArray(),
        compiledMessage.toByteArray(),
      ]);
}

extension BinaryReaderExt on BinaryReader {
  int readCompactU16Value() {
    final keysLength = CompactU16.raw(buf.buffer.asUint8List(offset));

    for (int i = 0; i < keysLength.size; i++) {
      readU8();
    }

    return keysLength.value;
  }
}
