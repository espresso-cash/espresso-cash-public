import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/src/common/byte_array.dart';
import 'package:solana/src/constants.dart';
import 'package:solana/src/encoder/compact_u16.dart';

part 'compiled_message.freezed.dart';

@freezed
class CompiledMessage with _$CompiledMessage {
  const factory CompiledMessage(ByteArray data) = _CompiledMessage;

  factory CompiledMessage.fromSignedTransaction(ByteArray data) {
    final signaturesCount = CompactU16.raw(data.toList()).value;

    return CompiledMessage(
      ByteArray(
        Uint8List.fromList(
          data.skip(1 + signaturesCount * signatureLength).toList(),
        ),
      ),
    );
  }

  const CompiledMessage._();

  int get requiredSignatureCount => data.first;
}
