part of 'encoder.dart';

/// Represents a signed transaction that consists of the transaction
/// message and an array of signatures. The array of signatures must
/// be populated following the solana convention for the set of addresses
/// that they belong to within the message.
class SignedTx extends Iterable<int> {
  SignedTx({
    Iterable<Signature> signatures = const Iterable<Signature>.empty(),
    required Iterable<int> messageBytes,
  }) : _data = Buffer.fromByteArrays([
          CompactArray.fromIterable(signatures),
          messageBytes,
        ]);

  final Iterable<int> _data;

  @override
  Iterator<int> get iterator => _data.iterator;
}
