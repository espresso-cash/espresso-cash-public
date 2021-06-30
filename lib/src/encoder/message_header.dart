import 'package:solana/src/common/byte_array.dart';
import 'package:solana/src/encoder/account_meta.dart';
import 'package:solana/src/encoder/buffer.dart';
import 'package:solana/src/encoder/extensions.dart';

/// The message header as described [Message Header Format][message header format]
///
/// [message header format]: https://docs.solana.com/developing/programming-model/transactions#message-header-format
class MessageHeader extends ByteArray {
  MessageHeader._({
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
  factory MessageHeader.fromAccounts(List<AccountMeta> accounts) =>
      MessageHeader._(
        numRequiredSignatures: accounts.getNumSigners(),
        numReadonlySignedAccounts: accounts.getNumReadonlySigners(),
        numReadonlyUnsignedAccounts: accounts.getNumReadonlyNonSigners(),
      );

  final ByteArray _data;

  @override
  Iterator<int> get iterator => _data.iterator;
}
