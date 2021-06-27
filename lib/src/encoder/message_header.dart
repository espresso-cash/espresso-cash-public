part of 'encoder.dart';

/// The message header as described [Message Header Format][message header format]
///
/// [message header format]: https://docs.solana.com/developing/programming-model/transactions#message-header-format
class _MessageHeader extends ByteArray {
  _MessageHeader._({
    required int numRequiredSignatures,
    required int numReadonlySignedAccounts,
    required int numReadonlyUnsignedAccounts,
  }) : _data = Buffer.fromConcatenatedByteArrays([
          Buffer.fromUint8(numRequiredSignatures),
          Buffer.fromUint8(numReadonlySignedAccounts),
          Buffer.fromUint8(numReadonlyUnsignedAccounts),
        ]);

  /// Constructs a message header by counting signers, and readonly accounts
  /// from [accounts].
  factory _MessageHeader.fromAccounts(Iterable<AccountMeta> accounts) =>
      _MessageHeader._(
        numRequiredSignatures: accounts.getNumSigners(),
        numReadonlySignedAccounts: accounts.getNumReadonlySigners(),
        numReadonlyUnsignedAccounts: accounts.getNumReadonlyNonSigners(),
      );

  final ByteArray _data;

  @override
  Iterator<int> get iterator => _data.iterator;
}
