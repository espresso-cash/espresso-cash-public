import 'dart:convert';

import 'package:solana/src/crypto/signature.dart';
import 'package:solana/src/encoder/byte_array.dart';
import 'package:solana/src/encoder/compact_array.dart';

/// Represents a signed transaction that consists of the transaction message and
/// an array of signatures. The array of signatures must be populated following
/// the solana convention for the set of addresses that they belong to within
/// the message.
class SignedTx {
  SignedTx({
    this.signatures = const Iterable<Signature>.empty(),
    required this.messageBytes,
  });

  final Iterable<Signature> signatures;
  final ByteArray messageBytes;

  String encode() => base64.encode(_data.toList());

  late final ByteArray _data = ByteArray.merge([
    CompactArray.fromIterable(signatures.map((e) => ByteArray(e.bytes)))
        .toByteArray(),
    messageBytes,
  ]);

  ByteArray toByteArray() => _data;
}
