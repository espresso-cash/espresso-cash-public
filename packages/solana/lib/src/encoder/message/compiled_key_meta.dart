import 'package:freezed_annotation/freezed_annotation.dart';

part 'compiled_key_meta.freezed.dart';

@freezed
class CompiledKeyMeta with _$CompiledKeyMeta {
  const factory CompiledKeyMeta({
    required bool isSigner,
    required bool isWritable,
    required bool isInvoked,
  }) = _CompiledKeyMeta;
}
