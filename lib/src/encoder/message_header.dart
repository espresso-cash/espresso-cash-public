part of 'encoder.dart';

/// The message header as described [Message Header Format][message header format]
///
/// [message header format]: https://docs.solana.com/developing/programming-model/transactions#message-header-format
class MessageHeader extends Iterable<int> {
  MessageHeader._({
    required int numRequiredSignatures,
    required int numReadonlySignedAccounts,
    required int numReadonlyUnsignedAccounts,
  }) : _data = [
          ...SerializableInt.from(numRequiredSignatures),
          ...SerializableInt.from(numReadonlySignedAccounts),
          ...SerializableInt.from(numReadonlyUnsignedAccounts),
        ];

  /// Constructs a message header by counting signers, and readonly accounts
  /// from [accounts].
  factory MessageHeader.fromAccounts(Iterable<AccountMeta> accounts) =>
      MessageHeader._(
        numRequiredSignatures: accounts.getNumSigners(),
        numReadonlySignedAccounts: accounts.getNumReadonlySigners(),
        numReadonlyUnsignedAccounts: accounts.getNumReadonlyNonSigners(),
      );

  final Iterable<int> _data;

  @override
  Iterator<int> get iterator => _data.iterator;
}
