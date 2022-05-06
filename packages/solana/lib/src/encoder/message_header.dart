import 'package:solana/encoder.dart';

/// The message header as described [Message Header Format][message header format]
///
/// [message header format]: https://docs.solana.com/developing/programming-model/transactions#message-header-format
class MessageHeader {
  MessageHeader._({
    required int numRequiredSignatures,
    required int numReadonlySignedAccounts,
    required int numReadonlyUnsignedAccounts,
  }) : _data = ByteArray.merge([
          ByteArray.u8(numRequiredSignatures),
          ByteArray.u8(numReadonlySignedAccounts),
          ByteArray.u8(numReadonlyUnsignedAccounts),
        ]);

  /// Constructs a message header by counting signers, and readonly accounts
  /// from [accounts].
  factory MessageHeader.fromAccounts(List<AccountMeta> accounts) =>
      MessageHeader._(
        numRequiredSignatures: accounts.getNumSigners(),
        numReadonlySignedAccounts: accounts.getNumReadonlySigners(),
        numReadonlyUnsignedAccounts: accounts.getNumReadonlyNonSigners(),
      );

  final ByteArray _data;

  ByteArray toByteArray() => _data;
}
