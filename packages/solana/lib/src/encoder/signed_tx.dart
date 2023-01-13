import 'dart:convert';

import 'package:borsh_annotation/borsh_annotation.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/src/constants.dart';
import 'package:solana/src/encoder/compact_array.dart';
import 'package:solana/src/encoder/compact_u16.dart';
import 'package:solana/src/encoder/encoder.dart';
import 'package:solana/src/encoder/transaction/legacy.dart';
import 'package:solana/src/encoder/transaction/v0.dart';
import 'package:solana/src/encoder/transaction/version.dart';

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

    final prefix = messageBytes.first;
    final maskedPrefix = prefix & 0x7f;

    Iterable<Signature> signatures = const Iterable<Signature>.empty();

    if (prefix == maskedPrefix) {
      final txData = TxLegacy.decompile(messageBytes);

      signatures = signaturesData.mapIndexed(
        (i, s) => Signature(s, publicKey: txData.accounts[i].pubKey),
      );
    } else if (maskedPrefix == 0) {
      final txData = TxV0.decompile(messageBytes);

      signatures = signaturesData.mapIndexed(
        (i, s) => Signature(s, publicKey: txData.staticAccountKeys[i]),
      );
    }

    return SignedTx(
      signatures: signatures,
      messageBytes: ByteArray(messageBytes),
    );
  }

  String get blockhash => _txData.blockhash;

  late final Message message = Message(instructions: _txData.instructions);

//  v0 message decoding
//  Message message({
//     LoadedAddresses? accountKeysFromLookups,
//     List<AddressLookupTableAccount>? addressLookupTableAccounts,
//   }) =>
//       _txData.decode(
//         accountKeysFromLookups: accountKeysFromLookups,
//         addressLookupTableAccounts: addressLookupTableAccounts,
//       );

  List<AccountMeta> get accounts => _txData.accounts.toList();

  late final TxLegacy _txData = TxLegacy.decompile(messageBytes);

  final Iterable<Signature> signatures;
  final ByteArray messageBytes;

  String get id => signatures.first.toBase58();

  String encode() => base64.encode(_data.toList());

  late final ByteArray _data = ByteArray.merge([
    CompactArray.fromIterable(signatures.map((e) => ByteArray(e.bytes)))
        .toByteArray(),
    messageBytes,
  ]);

  TransactionVersion get version {
    final prefix = messageBytes.first;
    final maskedPrefix = prefix & 0x7f;

    if (prefix == maskedPrefix) {
      return TransactionVersion.legacy;
    }

    return TransactionVersion.v0;
  }

  ByteArray toByteArray() => _data;
}

extension BinaryReaderExt on BinaryReader {
  int readCompactU16Value() {
    final keysLength = CompactU16.raw(buf.buffer.asUint8List(offset));

    for (var i = 0; i < keysLength.size; i++) {
      readU8();
    }

    return keysLength.value;
  }
}

abstract class TxData {}
