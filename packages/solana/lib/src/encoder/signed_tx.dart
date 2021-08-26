import 'dart:convert';

import 'package:solana/src/base58/encode.dart';
import 'package:solana/src/common/byte_array.dart';
import 'package:solana/src/common/encoding_type.dart';
import 'package:solana/src/encoder/buffer.dart';
import 'package:solana/src/encoder/compact_array.dart';
import 'package:solana/src/encoder/signature.dart';

/// Represents a signed transaction that consists of the transaction
/// message and an array of signatures. The array of signatures must
/// be populated following the solana convention for the set of addresses
/// that they belong to within the message.
class SignedTx extends ByteArray {
  SignedTx({
    Iterable<Signature> signatures = const Iterable<Signature>.empty(),
    required ByteArray messageBytes,
  }) : _data = Buffer.fromConcatenatedByteArrays([
          CompactArray.fromIterable(signatures),
          messageBytes,
        ]);

  final ByteArray _data;

  @override
  Iterator<int> get iterator => _data.iterator;

  String encode({EncodingType encodingType = EncodingType.base58}) {
    switch (encodingType) {
      case EncodingType.base64:
        return base64.encode(toList(growable: false));
      case EncodingType.base58:
        return base58encode(toList(growable: false));
    }
  }
}
