import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/src/encoder/byte_array.dart';
import 'package:solana/src/encoder/compact_array.dart';

part 'compiled_instruction.freezed.dart';

@freezed
class CompiledInstruction with _$CompiledInstruction {
  const factory CompiledInstruction({
    required int programIdIndex,
    required List<int> accountKeyIndexes,
    required ByteArray data,
  }) = _CompiledInstruction;

  const CompiledInstruction._();

  ByteArray toByteArray() => ByteArray.merge([
        ByteArray.u8(programIdIndex),
        CompactArray(ByteArray(accountKeyIndexes)).toByteArray(),
        CompactArray(data).toByteArray(),
      ]);
}
