import 'package:solana/src/common/byte_array.dart';
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
}
