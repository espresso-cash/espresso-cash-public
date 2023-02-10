import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';

part 'message_header.freezed.dart';

/// The message header as described [Message Header Format][message header format]
///
/// [message header format]: https://docs.solana.com/developing/programming-model/transactions#message-header-format
@freezed
class MessageHeader with _$MessageHeader {
  const factory MessageHeader({
    required int numRequiredSignatures,
    required int numReadonlySignedAccounts,
    required int numReadonlyUnsignedAccounts,
  }) = _MessageHeader;

  const MessageHeader._();

  /// Constructs a message header by counting signers, and readonly accounts
  /// from [accounts].
  factory MessageHeader.fromAccounts(List<AccountMeta> accounts) =>
      MessageHeader(
        numRequiredSignatures: accounts.getNumSigners(),
        numReadonlySignedAccounts: accounts.getNumReadonlySigners(),
        numReadonlyUnsignedAccounts: accounts.getNumReadonlyNonSigners(),
      );

  ByteArray toByteArray() => ByteArray.merge([
        ByteArray.u8(numRequiredSignatures),
        ByteArray.u8(numReadonlySignedAccounts),
        ByteArray.u8(numReadonlyUnsignedAccounts),
      ]);
}
