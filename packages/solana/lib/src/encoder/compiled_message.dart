import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/src/constants.dart';
import 'package:solana/src/encoder/byte_array.dart';
import 'package:solana/src/encoder/compact_u16.dart';

part 'compiled_message.freezed.dart';

@freezed
class CompiledMessage with _$CompiledMessage {
  const factory CompiledMessage(ByteArray data) = _CompiledMessage;

  @Deprecated('Use SignedTx.decode')
  factory CompiledMessage.fromSignedTransaction(ByteArray data) {
    final signaturesCount = CompactU16.raw(data.toList()).value;

    return CompiledMessage(
      ByteArray(data.skip(1 + signaturesCount * signatureLength)),
    );
  }

  const CompiledMessage._();

  int get requiredSignatureCount => data.first;
}
