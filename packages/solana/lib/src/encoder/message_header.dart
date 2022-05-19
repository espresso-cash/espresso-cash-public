import 'package:solana/encoder.dart';

/// The message header as described [Message Header Format][message header format]
///
/// [message header format]: https://docs.solana.com/developing/programming-model/transactions#message-header-format
class MessageHeader {
  MessageHeader({
    required this.numRequiredSignatures,
    required this.numReadonlySignedAccounts,
    required this.numReadonlyUnsignedAccounts,
  });

  /// Constructs a message header by counting signers, and readonly accounts
  /// from [accounts].
  factory MessageHeader.fromAccounts(List<AccountMeta> accounts) =>
      MessageHeader(
        numRequiredSignatures: accounts.getNumSigners(),
        numReadonlySignedAccounts: accounts.getNumReadonlySigners(),
        numReadonlyUnsignedAccounts: accounts.getNumReadonlyNonSigners(),
      );

  final int numRequiredSignatures;
  final int numReadonlySignedAccounts;
  final int numReadonlyUnsignedAccounts;

  ByteArray toByteArray() => ByteArray.merge([
        ByteArray.u8(numRequiredSignatures),
        ByteArray.u8(numReadonlySignedAccounts),
        ByteArray.u8(numReadonlyUnsignedAccounts),
      ]);
}
